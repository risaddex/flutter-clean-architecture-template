import 'package:flutter_clean_architecture_template/core/result.dart';
import 'package:flutter_clean_architecture_template/data/repositories/auth/auth_repository.dart';
import 'package:flutter_clean_architecture_template/data/services/local/secure_storage_service.dart';
import 'package:flutter_clean_architecture_template/domain/models/auth_session.dart';

class LoginUseCase {
  LoginUseCase({
    required AuthRepository authRepository,
    required SecureStorageService storage,
  })  : _authRepository = authRepository,
        _storage = storage;

  final AuthRepository _authRepository;
  final SecureStorageService _storage;

  Future<Result<AuthSession>> call({
    required String email,
    required String password,
  }) async {
    final result = await _authRepository.login(
      email: email,
      password: password,
    );

    return result.fold(
      (session) async {
        await _storage.saveToken(session.token);
        await _storage.saveRefreshToken(session.refreshToken);
        return Result.ok(session);
      },
      (error) => Result.error(error),
    );
  }
}
