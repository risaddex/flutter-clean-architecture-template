# Clean Architecture Overview

This template follows **Clean Architecture** principles as outlined by Robert C. Martin.

## Layers

### 1. Presentation Layer (UI)

**Location**: `lib/ui/`

Responsible for:
- Rendering widgets and screens
- Handling user input
- Displaying loading and error states
- Listening to ViewModel state changes

**Key classes**:
- `*Screen` - StatelessWidget that displays data
- `*ViewModel` - ChangeNotifier managing state
- `*Bindings` - MultiProvider setting up dependencies

**Should NOT**:
- Call APIs directly
- Access repositories
- Know about database or network details

### 2. Domain Layer

**Location**: `lib/domain/`

Responsible for:
- Business logic and rules
- Domain models (User, AuthSession, etc.)
- Use cases (login, logout, refresh)

**Key classes**:
- `*UseCase` - Encapsulates a business operation
- Domain models - Pure data classes

**Should NOT**:
- Know about UI frameworks
- Know about HTTP or database details
- Have any Android/iOS specific code

### 3. Data Layer

**Location**: `lib/data/`

Responsible for:
- Repository implementations
- API clients (Dio, Retrofit)
- Local storage (SQLite, Hive, SharedPreferences)
- Data mappers (DTOs to domain models)

**Key classes**:
- `*Repository` - Interface
- `*RepositoryRemote` - Implements repository with API
- API services and interceptors
- Storage services

**Should NOT**:
- Expose domain models directly
- Know about UI or ViewModels
- Have business logic

### 4. Core Layer

**Location**: `lib/core/`

Responsible for:
- Shared abstractions
- Cross-cutting concerns
- Result type
- Exception handling
- Logging

**Key classes**:
- `Result<T>` - Success/error wrapper
- `Command<T>` - Async operation handler
- `ViewModelInitializable` - Lazy init interface
- `AppException` - Exception hierarchy
- `AppLogger` - Logging service

### 5. Config Layer

**Location**: `lib/config/`

Responsible for:
- Environment configuration
- Global dependency registration
- App initialization

**Key classes**:
- `Environment` - API endpoints, build flags
- `ApplicationBindings` - Provider setup

## Data Flow

```
UI (Screen + ViewModel)
    ↓
Use Case
    ↓
Repository (Interface)
    ↓
Repository Remote (Implementation)
    ↓
API Service / Local Storage
    ↓
External Data Source (API / Database)
```

## Dependency Direction

```
Presentation → Domain ← Data
    ↓                       ↓
    └────→ Core ←──────────┘
         (Shared)
```

**Key**: Inner layers should NOT depend on outer layers.

## Communication

### UI → Domain → Data

1. User interacts with UI
2. ViewModel calls UseCase
3. UseCase calls Repository
4. Repository calls API/Storage
5. Result is wrapped in Result<T>
6. ViewModel updates state
7. Screen re-renders

## Example: Login Flow

1. **Screen**: User enters email/password, taps "Login"
2. **ViewModel**: Calls `loginUseCase.call(email, password)`
3. **UseCase**: Calls `authRepository.login(...)`
4. **Repository**: Calls `authApi.login(...)`
5. **API Client**: Makes HTTP POST request
6. **Result**: Receives response or error
7. **Repository**: Maps to domain model or exception, returns `Result<AuthSession>`
8. **UseCase**: Stores token, returns `Result<AuthSession>`
9. **ViewModel**: Updates state, calls `notifyListeners()`
10. **Screen**: Watches ViewModel, re-renders with new state

## Benefits

✅ **Testability**: Each layer can be tested independently
✅ **Maintainability**: Clear responsibilities and separation
✅ **Scalability**: Easy to add new features
✅ **Flexibility**: Can swap implementations (mock repos for tests)
✅ **Reusability**: Components can be used in different contexts

## Potential Pitfalls

❌ Mixing layers (UI accessing repositories directly)
❌ Over-engineering (too many abstractions for simple apps)
❌ Not using dependency injection (tight coupling)
❌ Ignoring error handling (not using Result<T>)
❌ Large, unfocused use cases (should have single responsibility)
