# AGENTS.md

## Objective

Create and maintain Flutter applications using a reusable clean architecture approach.

## Principles

- Keep data access in `lib/data`.
- Keep business logic in `lib/domain/use_cases`.
- Keep UI state in `lib/ui/*/*_viewmodel.dart`.
- Keep routing in `lib/routing`.
- Use `Result<T>` for success/error handling.
- Use `Provider` for dependency injection.
- Use `ChangeNotifier` for view state.
- Use `GoRouter` for navigation.
- Keep features isolated by folder.

## Rules

1. UI should not call repositories directly.
2. All repository methods should return `Result<T>`.
3. Use cases should be small and reusable.
4. Every feature should have screen + viewmodel + bindings.
5. Routes belong in `lib/routing/routes.dart`.
6. Dependencies belong in `lib/config/application_bindings.dart`.
7. Log via `AppLogger` instead of `print()`.
8. Keep commits small and focused.

## Workflow

- Add a feature folder under `lib/ui`.
- Create its ViewModel and screen.
- Register dependencies in global bindings.
- Add route definitions and redirect logic.
- Keep API calls behind repositories and use cases.
