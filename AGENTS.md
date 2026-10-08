# AGENTS.md - Flutter Clean Architecture Template

## Objective

Create and maintain Flutter applications using clean architecture, repository pattern, and provider-based dependency injection.

## Principles

1. **Separation of Concerns**
   - UI layer: screens, view models, and bindings
   - Domain layer: models and use cases (business logic)
   - Data layer: repositories, services, and DTOs
   - Config layer: dependency registration and environment

2. **Dependency Injection**
   - Use Provider for DI
   - Register all dependencies in `ApplicationBindings`
   - Never create instances directly in widgets

3. **Error Handling**
   - Use `Result<T>` instead of throwing exceptions
   - Map external exceptions to `AppException` types
   - Always handle errors at the ViewModel level

4. **State Management**
   - Use `ChangeNotifier` for view models
   - Use `ViewModelInitializable` for lazy init
   - Notify listeners only when state actually changes

5. **Navigation**
   - All routes declared in `lib/routing/routes.dart`
   - Use `GoRouter` for navigation
   - Auth guards in `redirect` method

## Rules

1. **UI** should never call APIs directly
   - Always go through repositories

2. **Repositories** always return `Result<T>`
   - Never throw exceptions from repositories
   - Map external exceptions to AppException types

3. **Use Cases** should be small and focused
   - One responsibility per use case
   - Can combine multiple repositories
   - Always return `Result<T>`

4. **ViewModels** should:
   - Extend `ChangeNotifier`
   - Implement `ViewModelInitializable` if they need init
   - Only call use cases and ViewModels
   - Never call repositories directly

5. **Features** must have:
   - `*_screen.dart` - UI component
   - `*_viewmodel.dart` - State and logic
   - `*_bindings.dart` - Dependency setup

6. **Routes** must be:
   - Declared in `Routes` class
   - Marked as public or private
   - Guarded in `buildRouter` redirect

7. **Logging** must use:
   - `AppLogger` instead of `print()`
   - Configured in `main()`
   - Extensible via `LogOutput` interface

8. **Dependencies** must be:
   - Registered in `ApplicationBindings`
   - Injected via `context.read()` or `context.watch()`
   - Never created with `new` in widgets

## Workflow for New Feature

1. **Create feature folder**
   ```
   lib/ui/<feature>/
   ├── <feature>_screen.dart
   ├── <feature>_viewmodel.dart
   └── <feature>_bindings.dart
   ```

2. **Create ViewModel**
   ```dart
   class FeatureViewModel extends ChangeNotifier implements ViewModelInitializable {
     @override
     void init() { /* load data */ }
   }
   ```

3. **Create Bindings**
   ```dart
   class FeatureBindings extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return MultiProvider(
         providers: [
           ChangeNotifierProvider(create: (_) => FeatureViewModel(...).initialized()),
         ],
         builder: (_, __) => screenBuilder(context),
       );
     }
   }
   ```

4. **Create Screen**
   ```dart
   class FeatureScreen extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       final vm = context.watch<FeatureViewModel>();
       return Scaffold(/* use vm state */);
     }
   }
   ```

5. **Add Route**
   ```dart
   // lib/routing/routes.dart
   static const String feature = '/feature';
   
   // lib/routing/app_router.dart
   GoRoute(path: Routes.feature, builder: (...) => FeatureBindings(...))
   ```

6. **Register Dependencies** (if needed)
   ```dart
   // lib/config/application_bindings.dart
   Provider(create: (_) => FeatureRepository(...))
   ```

## Reusable Skills

### Skill: Create Repository
- Create interface in `lib/data/repositories/<feature>/<feature>_repository.dart`
- Create remote implementation
- Map exceptions to `AppException`
- Always return `Result<T>`

### Skill: Create Use Case
- Single responsibility
- Use repositories, not services
- Return `Result<T>`
- Make it testable (no side effects)

### Skill: Create Feature UI
- Screen + ViewModel + Bindings
- ViewModel extends ChangeNotifier + ViewModelInitializable
- Bindings setup providers with MultiProvider
- Screen watches ViewModel and reacts to changes

### Skill: Add Route Guard
- Check `sessionNotifier.isSignedIn` in redirect
- Redirect to login if not signed in and route is private
- Add route to `Routes.public` if public

### Skill: Handle Async Operations
- Use ViewModel methods that call use cases
- Set loading state before operation
- Handle result with `fold(onOk, onError)`
- Notify listeners when done

## Best Practices

- ✅ Keep use cases small and focused
- ✅ Use type safety (avoid dynamic, Object)
- ✅ Document public APIs
- ✅ Write tests for repositories and use cases
- ✅ Use named parameters in constructors
- ✅ Prefer composition over inheritance
- ✅ Keep layers separated and testable

## Common Mistakes

- ❌ Calling APIs directly from screens
- ❌ Throwing exceptions from repositories
- ❌ Creating instances with `new` in widgets
- ❌ Using `StatefulWidget` when `StatelessWidget` is enough
- ❌ Mixing UI and business logic in ViewModels
- ❌ Not using `ViewModelInitializable` for data loading
- ❌ Forgetting to register dependencies

## Testing

Example repository test:
```dart
test('AuthRepositoryRemote.login returns AuthSession on success', () async {
  final mockDio = MockDio();
  final repository = AuthRepositoryRemote(dio: mockDio);
  
  final result = await repository.login(email: 'test@test.com', password: '123');
  
  expect(result.isOk, true);
});
```

Example use case test:
```dart
test('LoginUseCase persists token on success', () async {
  final mockRepo = MockAuthRepository();
  final mockStorage = MockSecureStorage();
  final useCase = LoginUseCase(repository: mockRepo, storage: mockStorage);
  
  await useCase(email: 'test@test.com', password: '123');
  
  verify(mockStorage.saveToken(any)).called(1);
});
```

## Commits

- Keep commits small and focused
- Prefix: `feat:`, `fix:`, `test:`, `docs:`, `refactor:`
- Example: `feat: add login screen and use case`
