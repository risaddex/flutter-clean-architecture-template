import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/auth/auth_session_notifier.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.sessionNotifier});

  final AuthSessionNotifier sessionNotifier;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => sessionNotifier.restore());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 96),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
