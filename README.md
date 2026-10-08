# Flutter Clean Architecture Template

A reusable Flutter starter built around clean architecture, dependency injection, typed results, and route guards.

## Features

- Clean Architecture layering
- Provider-based dependency injection
- `Result<T>` error handling
- `ChangeNotifier` ViewModels
- `GoRouter` navigation with auth guards
- `Command<T>` async handling
- `AuthSessionNotifier` for session state
- Secure storage support
- Ready for feature-based extension

## Structure

```text
lib/
├── app/
├── config/
├── core/
├── data/
├── domain/
├── routing/
├── ui/
├── main.dart
└── ...
```

## Getting started

```bash
git clone https://github.com/risaddex/flutter-clean-architecture-template.git
cd flutter-clean-architecture-template
flutter pub get
flutter run
```

## Architecture rules

- Screens do not call APIs directly.
- Repositories handle persistence and remote access.
- Use cases contain business logic.
- ViewModels hold screen state.
- Routes are centralized in `lib/routing/routes.dart`.
- Dependencies are configured in `lib/config/application_bindings.dart`.

## Included patterns

- Repository Pattern
- Use Case Pattern
- ViewModel Pattern
- Result Pattern
- Provider DI
- Router Guard Pattern

## Usage

Create feature folders under `lib/ui/<feature>` and follow the same convention:

- `feature_screen.dart`
- `feature_viewmodel.dart`
- `feature_bindings.dart`

Add routes and register any dependencies in the global bindings.
