# Flutter Clean Architecture Template

A reusable Flutter template built around clean architecture, repository pattern, provider-based dependency injection, GoRouter navigation, and a typed `Result<T>` error model.

## Goals

- keep UI and business logic separated
- centralize app setup and dependency registration
- make feature modules easy to copy and extend
- provide reusable patterns for future projects

## Architecture

- `lib/app` — root app entry
- `lib/config` — environment and global bindings
- `lib/core` — reusable services, result model, exceptions, logging, helper abstractions
- `lib/data` — repositories, API clients, local storage, DTOs/mappers
- `lib/domain` — domain models and use cases
- `lib/routing` — route definitions and router guards
- `lib/ui` — feature screens, view models, and bindings

## Core patterns

- Provider + `MultiProvider` for dependency injection
- `ChangeNotifier` view models
- `Result<T>` for success/error handling
- `ViewModelInitializable` for lazy setup
- `GoRouter` navigation with redirects for auth state
- feature-level bindings for screen composition

## Reusable skills included

1. Repository skill
2. Use case skill
3. Feature binding skill
4. Router guard skill
5. Logging skill
6. Error handling skill
7. Test-first feature setup skill

## Getting started

1. Clone the repo and rename the package if needed.
2. Update `lib/config/environment.dart` for your API URL.
3. Register your repositories/services in `lib/config/application_bindings.dart`.
4. Add a feature folder under `lib/ui/<feature>`.
5. Add route definitions in `lib/routing/routes.dart`.

## Rules

- UI should never call APIs directly.
- Data access belongs in `lib/data`.
- Business logic belongs in `lib/domain/use_cases`.
- Navigation belongs in `lib/routing`.
- Errors should return `Result<T>` instead of throwing unchecked exceptions.

## Example feature flow

- `feature_screen.dart`
- `feature_viewmodel.dart`
- `feature_bindings.dart`
- route entry in `routes.dart`
- repository interface + remote implementation in `lib/data`
- use case in `lib/domain/use_cases`

## Suggested next steps

- add auth feature
- add home dashboard
- add app settings
- add unit tests for repositories and use cases
