# Bonfire App - Architecture Diagram

## Layer Structure

```
┌─────────────────────────────────────────────────────────────┐
│                     Presentation Layer                       │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Screens    │  │   Widgets    │  │    BLoC      │      │
│  │              │  │              │  │              │      │
│  │ - Fireplace  │  │ - Timer      │  │ - Events     │      │
│  │   Screen     │  │ - XP Bar     │  │ - States     │      │
│  │              │  │ - Buttons    │  │ - Logic      │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                           ↕ (Events/States)
┌─────────────────────────────────────────────────────────────┐
│                      Domain Layer                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Entities   │  │  Use Cases   │  │ Repositories │      │
│  │              │  │              │  │ (Interfaces) │      │
│  │ - Level      │  │ - Start      │  │              │      │
│  │ - Session    │  │   Session    │  │ - Session    │      │
│  │              │  │ - Update XP  │  │   Repository │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                           ↕ (Abstractions)
┌─────────────────────────────────────────────────────────────┐
│                       Data Layer                             │
│  ┌──────────────┐  ┌──────────────┐                         │
│  │ Repositories │  │ Data Sources │                         │
│  │    (Impl)    │  │              │                         │
│  │              │  │ - Local      │                         │
│  │ - Session    │  │   Storage    │                         │
│  │   Repo Impl  │  │              │                         │
│  └──────────────┘  └──────────────┘                         │
└─────────────────────────────────────────────────────────────┘
```

## Data Flow

### Session Start Flow
```
User Tap Start Button
        ↓
    UI Event
        ↓
SessionBloc.add(StartSessionEvent)
        ↓
StartSessionUseCase.call()
        ↓
SessionRepository.startSession()
        ↓
SessionRepositoryImpl creates Stream
        ↓
Timer emits every second
        ↓
SessionBloc receives updates
        ↓
emit(SessionRunning)
        ↓
UI Updates (BlocBuilder)
```

### XP Update Flow
```
Timer tick (every 5 seconds)
        ↓
SessionBloc.add(UpdateXPEvent)
        ↓
UpdateLevelUseCase.call()
        ↓
Repository.getCurrentLevel()
        ↓
Level.addXP()
        ↓
Repository.saveLevel()
        ↓
emit(SessionRunning with updated Level)
        ↓
XPProgressBar rebuilds
```

## Dependency Injection

```
GetIt Service Locator
        │
        ├── LocalDataSource
        │        ↓
        ├── SessionRepository
        │        ↓
        ├── StartSessionUseCase
        │        ↓
        ├── UpdateLevelUseCase
        │        ↓
        └── SessionBloc
                 ↓
           BlocProvider
                 ↓
           UI Screens
```

## State Management (BLoC Pattern)

```
┌──────────────────────────────────────────────────┐
│                  SessionBloc                     │
│                                                  │
│  Events          State Machine        States    │
│  ┌─────────┐    ┌──────────┐      ┌─────────┐  │
│  │ Start   │───→│          │─────→│ Initial │  │
│  │ Pause   │───→│  BLoC    │─────→│ Loading │  │
│  │ Resume  │───→│  Logic   │─────→│ Running │  │
│  │ Stop    │───→│          │─────→│ Paused  │  │
│  │ Update  │───→│          │─────→│Complete │  │
│  └─────────┘    └──────────┘      └─────────┘  │
└──────────────────────────────────────────────────┘
```

## Key Patterns

1. **Repository Pattern**: Abstracts data access
2. **Use Case Pattern**: Single responsibility per business action
3. **BLoC Pattern**: Reactive state management
4. **Dependency Injection**: Loose coupling, testability
5. **Clean Architecture**: Layer separation, dependency rule

## File Organization

```
bonfire_app/
├── lib/
│   ├── core/
│   │   └── di/
│   │       └── service_locator.dart
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── level.dart
│   │   │   └── focus_session.dart
│   │   ├── repositories/
│   │   │   └── session_repository.dart
│   │   └── usecases/
│   │       ├── start_session_usecase.dart
│   │       └── update_level_usecase.dart
│   ├── data/
│   │   ├── datasources/
│   │   │   └── local_datasource.dart
│   │   └── repositories/
│   │       └── session_repository_impl.dart
│   ├── presentation/
│   │   ├── bloc/
│   │   │   ├── session_bloc.dart
│   │   │   ├── session_event.dart
│   │   │   └── session_state.dart
│   │   ├── screens/
│   │   │   └── main_fireplace_screen.dart
│   │   ├── widgets/
│   │   │   ├── glass_container.dart
│   │   │   ├── timer_display.dart
│   │   │   ├── xp_progress_bar.dart
│   │   │   ├── focus_mode_button.dart
│   │   │   └── upgrade_button.dart
│   │   └── theme/
│   │       └── app_theme.dart
│   └── main.dart
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```
