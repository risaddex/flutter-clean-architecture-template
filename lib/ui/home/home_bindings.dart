import 'package:flutter/foundation.dart';

import 'package:flutter_clean_architecture_template/core/view_model_initializable.dart';

class HomeViewModel extends ChangeNotifier implements ViewModelInitializable {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  void init() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    _isLoading = true;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 250));

    _isLoading = false;
    notifyListeners();
  }
}
