import 'package:flutter/foundation.dart';

import 'package:flutter_clean_architecture_template/data/services/local/secure_storage_service.dart';

/// Tracks session restoration and authentication state.
class AuthSessionNotifier extends ChangeNotifier {
  AuthSessionNotifier({required SecureStorageService storage}) : _storage = storage;

  final SecureStorageService _storage;

  bool _isRestored = false;
  bool _isSignedIn = false;

  bool get isRestored => _isRestored;
  bool get isSignedIn => _isSignedIn;

  Future<void> restore() async {
    final token = await _storage.getToken();
    _isSignedIn = token != null && token.isNotEmpty;
    _isRestored = true;
    notifyListeners();
  }

  Future<void> signIn() async {
    _isSignedIn = true;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _storage.clearToken();
    _isSignedIn = false;
    notifyListeners();
  }
}
