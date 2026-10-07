import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'log_output.dart';

/// Central logger for application
/// Configure once in main() and use AppLogger(className) to create loggers
class AppLogger {
  AppLogger(this.name) : _logger = Logger(name);

  final String name;
  final Logger _logger;

  void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.fine(message, error, stackTrace);
  }

  void info(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.info(message, error, stackTrace);
  }

  void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.warning(message, error, stackTrace);
  }

  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe(message, error, stackTrace);
  }

  /// Configure root logger with level and outputs
  /// Call once in main() before runApp()
  static void configure({
    required Level level,
    required List<LogOutput> outputs,
  }) {
    Logger.root.level = level;
    Logger.root.onRecord.listen((record) {
      for (final output in outputs) {
        output.write(record);
      }
    });
  }
}
