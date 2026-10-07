import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_template/core/exceptions/app_exception.dart';
import 'package:flutter_clean_architecture_template/core/result.dart';

/// Base repository class with common error handling
abstract class BaseRepository {
  /// Handle exceptions and return Result
  /// Converts DioException and other exceptions to AppException
  Result<T> handleException<T>(
    Object? error,
    StackTrace? stackTrace,
  ) {
    if (error is DioException) {
      return Result.error(_mapDioException(error, stackTrace));
    }
    return Result.error(
      UnknownException(
        cause: error,
        stackTrace: stackTrace,
      ),
    );
  }

  /// Map DioException to AppException
  AppException _mapDioException(DioException error, StackTrace? stackTrace) {
    return switch (error.response?.statusCode) {
      401 => UnauthorizedException(
          cause: error,
          stackTrace: stackTrace,
        ),
      403 => AuthException(
          message: 'Access forbidden',
          cause: error,
          stackTrace: stackTrace,
        ),
      404 => ServerException(
          message: 'Resource not found',
          statusCode: 404,
          cause: error,
          stackTrace: stackTrace,
        ),
      >= 500 => ServerException(
          message: 'Server error',
          statusCode: error.response?.statusCode,
          cause: error,
          stackTrace: stackTrace,
        ),
      _ => NetworkException(
          message: error.message ?? 'Network error',
          cause: error,
          stackTrace: stackTrace,
        ),
    };
  }
}
