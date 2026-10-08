abstract class AppException implements Exception {
  AppException({required this.message, this.cause, this.stackTrace});

  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  String toString() => 'AppException: $message';
}

class NetworkException extends AppException {
  NetworkException({required super.message, super.cause, super.stackTrace});
}

class UnauthorizedException extends AppException {
  UnauthorizedException({required super.message, super.cause, super.stackTrace});
}

class UnknownException extends AppException {
  UnknownException({super.cause, super.stackTrace}) : super(message: 'Unexpected error');
}
