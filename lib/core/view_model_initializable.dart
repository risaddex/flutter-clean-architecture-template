import 'package:flutter/foundation.dart';

/// Interface for ViewModels that need initialization
/// Enables lazy initialization via .initialized() extension
abstract interface class ViewModelInitializable {
  void init();
}

/// Extension to initialize ChangeNotifier ViewModels
/// Usage: ChangeNotifierProvider(
///   create: (context) => HomeViewModel(...).initialized(),
/// )
extension ViewModelInitializableExtension<T extends ChangeNotifier> on T {
  /// Calls init() if this is ViewModelInitializable, then returns self
  T initialized() {
    if (this is ViewModelInitializable) {
      (this as ViewModelInitializable).init();
    }
    return this;
  }
}
