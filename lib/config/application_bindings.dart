# AGENTS.md

## Objective

Create and maintain Flutter applications using a reusable clean architecture approach.

## Principles

- Keep data access in `lib/data`.
- Keep business logic in `lib/domain/use_cases`.
- Keep UI state in `lib/ui/*/*_viewmodel.dart`.
- Keep dependency registration in `lib/config`.
- Keep routing in `lib/routing`.
- Use `Result<T>` for success/error handling.
- Use `Provider` for dependency injection.
- Use `ChangeNotifier` for view state.
- Use `GoRouter` for navigation.
- Keep features isolated by folder.

## Rules

1. Never mix repository logic into UI code.
2. Never call APIs directly from screens.
3. All repository methods return `Result<T>`.
4. All use cases should be small and reusable.
5. Every route should be declared in `lib/routing/routes.dart`.
6. Every feature should have: `screen`, `viewmodel`, and `bindings`.
7. Use `ViewModelInitializable` to initialize state.
8. Log via `AppLogger` instead of `print`.
9. Prefer named constructors and typed models.
10. Prefer small, testable functions.

## Workflow

- create feature folder with screen + viewmodel + bindings
- add route definitions
- inject dependencies in `ApplicationBindings`
- keep API mappers in `data/services/api/mappers`
- write tests for repositories and use cases
- keep commits small and focused

## Reusable skill set

- `repository skill`
- `use case skill`
- `feature ui skill`
- `router guard skill`
- `logging skill`
- `error handling skill`
- `test skill`
