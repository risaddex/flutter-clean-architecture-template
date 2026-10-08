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

### Option 1: Direct clone and run

```bash
git clone https://github.com/risaddex/flutter-clean-architecture-template.git
cd flutter-clean-architecture-template
flutter pub get
flutter run
```

### Option 2: Use as a template for a new project (preserves iOS/Android)

If you want to initialize the native iOS and Android directories properly while keeping the architecture code in `lib/`:

```bash
# 1. Clone the repository
git clone https://github.com/risaddex/flutter-clean-architecture-template.git my-app
cd my-app

# 2. Backup the lib folder (where all the app architecture lives)
cp -r lib lib.backup

# 3. Regenerate native platforms with a new app identity
rm -rf ios android .dart_tool pubspec.lock
flutter create --platforms ios,android .

# 4. Restore the architecture code
rm -rf lib
mv lib.backup lib

# 5. Update the app name in pubspec.yaml
# Edit pubspec.yaml and change:
#   name: flutter_clean_architecture_template
# to:
#   name: my_app

# 6. Install dependencies
flutter pub get

# 7. Run the app
flutter run
```

### Option 3: One-liner setup script

```bash
#!/bin/bash

APP_NAME="my_app"
TEMPLATE_PATH="flutter-clean-architecture-template"

git clone https://github.com/risaddex/flutter-clean-architecture-template.git "$APP_NAME"
cd "$APP_NAME"

cp -r lib lib.backup
rm -rf ios android .dart_tool pubspec.lock
flutter create --platforms ios,android .
rm -rf lib
mv lib.backup lib

# Update pubspec.yaml
sed -i.bak "s/name: flutter_clean_architecture_template/name: $APP_NAME/" pubspec.yaml
rm pubspec.yaml.bak

flutter pub get
echo "✅ Setup complete! Run: cd $APP_NAME && flutter run"
```

Save as `setup.sh`, run `chmod +x setup.sh`, then `./setup.sh`.

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

## Why regenerate iOS/Android?

When you clone this template, the `ios/` and `android/` directories are generated with the template's default app identity. If you want your app to have its own unique identity:

- different bundle ID for App Store / Google Play
- your app name in native code
- fresh platforms setup for a new project

The steps above regenerate those directories while preserving the architecture in `lib/`, so you keep the clean architecture template without losing the native platform scaffolding.

## License

MIT
