import 'package:flutter_clean_architecture_template/core/result.dart';
import 'package:flutter_clean_architecture_template/data/repositories/auth/auth_repository.dart';
import 'package:flutter_clean_architecture_template/data/services/local/secure_storage_service.dart';

class LogoutUseCase {
  LogoutUseCase({
    required AuthRepository authRepository,
    required SecureStorageService storage,
  })  : _authRepository = authRepository,
        _storage = storage;

  final AuthRepository _authRepository;
  final SecureStorageService _storage;

  Future<Result<void>> call() async {
    try {
      final result = await _authRepository.logout();
      await _storage.clearToken();
      return result;
    } catch (e, st) {
      await _storage.clearToken();
      return Result.error(
        UnknownException(cause: e, stackTrace: st),
      );
    }
  }
}
