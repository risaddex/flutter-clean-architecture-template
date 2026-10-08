import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/app.dart';
import 'package:flutter_clean_architecture_template/config/application_bindings.dart';
import 'package:flutter_clean_architecture_template/core/logging/app_logger.dart';
import 'package:flutter_clean_architecture_template/core/logging/log_output.dart';
import 'package:logging/logging.dart';

void main() {
  AppLogger.configure(
    level: kDebugMode ? Level.ALL : Level.INFO,
    outputs: const [ConsoleLogOutput()],
  );

  runApp(
    const ApplicationBindings(
      child: App(),
    ),
  );
}
