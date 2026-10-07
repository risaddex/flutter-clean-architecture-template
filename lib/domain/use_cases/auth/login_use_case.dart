import 'package:flutter_clean_architecture_template/core/result.dart';
import 'package:flutter_clean_architecture_template/data/repositories/auth/auth_repository.dart';
import 'package:flutter_clean_architecture_template/data/services/local/secure_storage_service.dart';
import 'package:flutter_clean_architecture_template/domain/models/auth_session.dart';

/// Login use case
/// Authenticates user and persists session
class LoginUseCase {
  LoginUseCase({
    required AuthRepository authRepository,
    required SecureStorageService storage,
  })
      : _authRepository = authRepository,
        _storage = storage;

  final AuthRepository _authRepository;
  final SecureStorageService _storage;

  /// Execute login with email and password
  Future<Result<AuthSession>> call({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authRepository.login(
        email: email,
        password: password,
      );

      return result.fold(
        (session) async {
          // Persist tokens
          await _storage.saveToken(session.token);
          await _storage.saveRefreshToken(session.refreshToken);
          return Result.ok(session);
        },
        (error) => Result.error(error),
      ) as Result<AuthSession>;
    } catch (e, st) {
      return Result.error(
        UnknownException(cause: e, stackTrace: st),
      );
    }
  }
}
