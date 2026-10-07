/// Base exception class for all application errors
abstract class AppException implements Exception {
  AppException({
    required this.message,
    this.cause,
    this.stackTrace,
  });

  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  String toString() => 'AppException: $message';
}

/// Network/API related exceptions
class NetworkException extends AppException {
  NetworkException({
    required super.message,
    super.cause,
    super.stackTrace,
  });
}

/// Authentication exceptions
class AuthException extends AppException {
  AuthException({
    required super.message,
    super.cause,
    super.stackTrace,
  });
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException({
    super.cause,
    super.stackTrace,
  }) : super(message: 'Invalid email or password');
}

class UnauthorizedException extends AuthException {
  UnauthorizedException({
    super.cause,
    super.stackTrace,
  }) : super(message: 'User is not authorized');
}

class SessionExpiredException extends AuthException {
  SessionExpiredException({
    super.cause,
    super.stackTrace,
  }) : super(message: 'Session has expired');
}

/// Server/API exceptions
class ServerException extends AppException {
  ServerException({
    required super.message,
    this.statusCode,
    super.cause,
    super.stackTrace,
  });

  final int? statusCode;
}

/// Validation exceptions
class ValidationException extends AppException {
  ValidationException({
    required super.message,
    this.field,
    super.cause,
    super.stackTrace,
  });

  final String? field;
}

/// Generic exception for unmapped errors
class UnknownException extends AppException {
  UnknownException({
    super.cause,
    super.stackTrace,
  }) : super(message: 'An unexpected error occurred');
}
