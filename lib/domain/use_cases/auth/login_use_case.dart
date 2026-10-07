import 'package:dio/dio.dart';

import 'package:flutter_clean_architecture_template/core/exceptions/app_exception.dart';
import 'package:flutter_clean_architecture_template/core/result.dart';
import 'package:flutter_clean_architecture_template/data/repositories/auth/auth_repository.dart';
import 'package:flutter_clean_architecture_template/data/services/local/secure_storage_service.dart';
import 'package:flutter_clean_architecture_template/domain/models/auth_session.dart';

class AuthRepositoryRemote implements AuthRepository {
  AuthRepositoryRemote({
    required Dio dio,
    required SecureStorageService storage,
  })  : _dio = dio,
        _storage = storage;

  final Dio _dio;
  final SecureStorageService _storage;

  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode != 200 || response.data == null) {
        return Result.error(
          ServerException(
            message: 'Login response invalid',
            statusCode: response.statusCode,
          ),
        );
      }

      final session = AuthSession(
        userId: '${response.data['user_id'] ?? 'user'}',
        email: response.data['email'] ?? email,
        name: response.data['name'] ?? 'User',
        token: '${response.data['token'] ?? ''}',
        refreshToken: '${response.data['refresh_token'] ?? ''}',
        expiresAt: DateTime.now().add(const Duration(hours: 8)),
      );

      await _storage.saveToken(session.token);
      await _storage.saveRefreshToken(session.refreshToken);

      return Result.ok(session);
    } on DioException catch (e, st) {
      return Result.error(
        NetworkException(
          message: e.message ?? 'Login error',
          cause: e,
          stackTrace: st,
        ),
      );
    } catch (e, st) {
      return Result.error(
        UnknownException(cause: e, stackTrace: st),
      );
    }
  }

  @override
  Future<Result<void>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Result.done;
      }

      return Result.error(
        ServerException(
          message: 'Registration failed',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e, st) {
      return Result.error(
        NetworkException(
          message: e.message ?? 'Registration error',
          cause: e,
          stackTrace: st,
        ),
      );
    } catch (e, st) {
      return Result.error(
        UnknownException(cause: e, stackTrace: st),
      );
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _dio.post('/auth/logout');
      await _storage.clearToken();
      return Result.done;
    } on DioException catch (e, st) {
      await _storage.clearToken();
      return Result.error(
        NetworkException(
          message: e.message ?? 'Logout error',
          cause: e,
          stackTrace: st,
        ),
      );
    } catch (e, st) {
      await _storage.clearToken();
      return Result.error(
        UnknownException(cause: e, stackTrace: st),
      );
    }
  }
}
