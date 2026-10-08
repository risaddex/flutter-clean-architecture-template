# Flutter Clean Architecture Template

A reusable, production-ready Flutter template built around **clean architecture**, **repository pattern**, **provider-based dependency injection**, and **GoRouter navigation**.

## Features

✅ Clean Architecture (UI / Domain / Data / Config)
✅ Provider for Dependency Injection
✅ GoRouter with authentication guards
✅ Result<T> for typed error handling
✅ ViewModelInitializable for lazy initialization
✅ AuthSessionNotifier for session management
✅ Command<T> pattern for async operations
✅ Secure token storage
✅ Reusable repository & use case patterns
✅ Feature-based UI structure

## Project Structure

```
lib/
├── app/
│   └── app.dart                 # Root MaterialApp
├── config/
│   ├── environment.dart         # API endpoints and build config
│   └── application_bindings.dart  # Global DI setup
├── core/
│   ├── result.dart              # Result<T> type for success/error
│   ├── command.dart             # Command<T> for async operations
│   ├── view_model_initializable.dart
│   ├── exceptions/
│   │   └── app_exception.dart   # Exception hierarchy
│   ├── auth/
│   │   └── auth_session_notifier.dart
│   └── logging/
│       ├── app_logger.dart
│       └── log_output.dart
├── data/
│   ├── repositories/
│   │   ├── base_repository.dart
│   │   └── auth/
│   │       ├── auth_repository.dart       # Interface
│   │       └── auth_repository_remote.dart  # Implementation
│   └── services/
│       ├── api/
│       │   ├── api_client.dart
│       │   └── interceptors/
│       │       └── auth_interceptor.dart
│       └── local/
│           └── secure_storage_service.dart
├── domain/
│   ├── models/
│   │   ├── auth_session.dart
│   │   └── user.dart
│   └── use_cases/
│       └── auth/
│           ├── login_use_case.dart
│           ├── logout_use_case.dart
│           └── restore_session_use_case.dart
├── routing/
│   ├── routes.dart        # Route path constants
│   └── app_router.dart    # GoRouter configuration with guards
└── ui/
    ├── auth/
    │   └── login/
    │       ├── login_screen.dart
    │       ├── login_viewmodel.dart
    │       └── login_bindings.dart
    ├── home/
    │   ├── home_screen.dart
    │   ├── home_viewmodel.dart
    │   └── home_bindings.dart
    └── splash/
        └── splash_screen.dart
```

## Key Patterns

### 1. Result<T> for Error Handling

```dart
Future<Result<AuthSession>> login() async {
  try {
    final session = await authApi.login();
    return Result.ok(session);
  } catch (e) {
    return Result.error(NetworkException(...));
  }
}
```

### 2. Repository Pattern

```dart
abstract interface class AuthRepository {
  Future<Result<AuthSession>> login({...});
}

class AuthRepositoryRemote implements AuthRepository {
  // Implementation with Dio
}
```

### 3. Use Case Pattern

```dart
class LoginUseCase {
  Future<Result<AuthSession>> call({
    required String email,
    required String password,
  }) => _authRepository.login(...);
}
```

### 4. ViewModel with ChangeNotifier

```dart
class LoginViewModel extends ChangeNotifier implements ViewModelInitializable {
  Future<void> login(String email, String password) async {
    _isBusy = true;
    notifyListeners();
    
    final result = await _loginUseCase(email: email, password: password);
    
    result.fold(
      (session) => _session = session,
      (error) => _error = error,
    );
    
    _isBusy = false;
    notifyListeners();
  }
}
```

### 5. Feature Bindings

```dart
class LoginBindings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => LoginUseCase(...)),
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(...).initialized(),
        ),
      ],
      builder: (_, __) => screenBuilder(context),
    );
  }
}
```

### 6. GoRouter with Auth Guards

```dart
GoRouter(
  initialLocation: Routes.splash,
  refreshListenable: sessionNotifier,
  redirect: (context, state) {
    if (!sessionNotifier.isRestored) return null;
    if (!sessionNotifier.isSignedIn) return Routes.login;
    return null;
  },
  routes: [...],
)
```

## Getting Started

1. **Clone and setup**
   ```bash
   git clone https://github.com/risaddex/flutter-clean-architecture-template.git
   cd flutter-clean-architecture-template
   flutter pub get
   ```

2. **Update environment**
   - Edit `lib/config/environment.dart` to point to your API

3. **Create a new feature**
   - Add screen in `lib/ui/<feature>`
   - Create `*_viewmodel.dart` and `*_bindings.dart`
   - Add routes in `lib/routing/routes.dart`
   - Register repository/use case in `ApplicationBindings`

4. **Run**
   ```bash
   flutter run
   ```

## Guidelines

- **Never** call APIs directly from UI
- **Always** use repositories for data access
- **Always** use use cases for business logic
- **Always** return `Result<T>` from repositories
- **Use** `ViewModelInitializable` for lazy initialization
- **Use** `AppLogger` for logging
- **Keep** features isolated in feature folders
- **Register** all dependencies in `ApplicationBindings`

## Testing

Example test for use case:

```dart
test('LoginUseCase should return AuthSession on success', () async {
  final mockRepo = MockAuthRepository();
  final useCase = LoginUseCase(authRepository: mockRepo);
  
  final result = await useCase(email: 'user@test.com', password: '123');
  
  expect(result, isA<Ok<AuthSession>>());
});
```

## Next Steps

- Add more features (Profile, Settings, etc.)
- Add API DTOs and mappers
- Add unit tests for repositories and use cases
- Add widget tests for screens
- Add integration tests
- Customize theme and branding

## License

MIT
