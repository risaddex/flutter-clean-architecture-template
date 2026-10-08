import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_clean_architecture_template/config/environment.dart';
import 'package:flutter_clean_architecture_template/core/auth/auth_session_notifier.dart';
import 'package:flutter_clean_architecture_template/data/services/local/secure_storage_service.dart';
import 'package:flutter_clean_architecture_template/routing/app_router.dart';

class ApplicationBindings extends StatelessWidget {
  const ApplicationBindings({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final storage = SecureStorageService();
    final dio = Dio(BaseOptions(baseUrl: Environment.baseUrl));
    final sessionNotifier = AuthSessionNotifier(storage: storage);
    final router = buildRouter(sessionNotifier);

    return MultiProvider(
      providers: [
        Provider<SecureStorageService>.value(value: storage),
        Provider<Dio>.value(value: dio),
        ChangeNotifierProvider<AuthSessionNotifier>.value(value: sessionNotifier),
        Provider<GoRouter>.value(value: router),
      ],
      child: child,
    );
  }
}
