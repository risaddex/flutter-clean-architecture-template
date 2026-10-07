import 'package:flutter_clean_architecture_template/core/result.dart';
import 'package:flutter_clean_architecture_template/data/repositories/auth/auth_repository.dart';
import 'package:flutter_clean_architecture_template/data/services/local/secure_storage_service.dart';

/// Logout use case
/// Clears session and persisted tokens
class LogoutUseCase {
  LogoutUseCase({
    required AuthRepository authRepository,
    required SecureStorageService storage,
  })
      : _authRepository = authRepository,
        _storage = storage;

  final AuthRepository _authRepository;
  final SecureStorageService _storage;

  /// Execute logout
  Future<Result<void>> call() async {
    try {
      // Call API to invalidate server-side session
      final result = await _authRepository.logout();

      // Always clear local tokens
      await _storage.clearToken();

      return result;
    } catch (e, st) {
      // Always clear local tokens on error
      await _storage.clearToken();
      return Result.error(
        UnknownException(cause: e, stackTrace: st),
      );
    }
  }
}
