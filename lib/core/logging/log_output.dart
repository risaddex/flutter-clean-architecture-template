import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

abstract interface class LogOutput {
  void write(LogRecord record);
}

class ConsoleLogOutput implements LogOutput {
  @override
  void write(LogRecord record) {
    final message = '${record.level.name} ${record.time} [${record.loggerName}] ${record.message}';
    debugPrint(message);
    if (record.error != null) debugPrint('error: ${record.error}');
    if (record.stackTrace != null) debugPrint(record.stackTrace.toString());
  }
}
