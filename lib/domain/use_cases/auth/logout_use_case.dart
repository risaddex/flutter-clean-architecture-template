import 'package:flutter_clean_architecture_template/core/result.dart';
import 'package:flutter_clean_architecture_template/data/services/local/secure_storage_service.dart';
import 'package:flutter_clean_architecture_template/domain/models/auth_session.dart';

class RestoreSessionUseCase {
  RestoreSessionUseCase({required SecureStorageService storage})
      : _storage = storage;

  final SecureStorageService _storage;

  Future<Result<AuthSession?>> call() async {
    try {
      final token = await _storage.getToken();
      final refreshToken = await _storage.getRefreshToken();

      if (token == null || refreshToken == null) {
        return Result.ok(null);
      }

      final session = AuthSession(
        userId: 'session-user',
        email: 'user@example.com',
        name: 'Session User',
        token: token,
        refreshToken: refreshToken,
        expiresAt: DateTime.now().add(const Duration(hours: 8)),
      );

      return Result.ok(session);
    } catch (e, st) {
      return Result.error(
        UnknownException(cause: e, stackTrace: st),
      );
    }
  }
}
