import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// Interface for log outputs
/// Implement to create custom log destinations (file, cloud, etc.)
abstract interface class LogOutput {
  void write(LogRecord record);
}

/// Console log output implementation
class ConsoleLogOutput implements LogOutput {
  @override
  void write(LogRecord record) {
    final buffer = StringBuffer()
      ..write('${record.level.name} ${record.time} '
          '[${record.loggerName}] ${record.message}');
    if (record.error != null) buffer.write('\nerror: ${record.error}');
    if (record.stackTrace != null) buffer.write('\n${record.stackTrace}');
    debugPrint(buffer.toString());
  }
}
