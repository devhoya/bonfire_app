# Bonfire Focus App

A gamified focus timer app with an immersive fireplace theme, built with Flutter using Clean Architecture and BLoC pattern.

## 🏗️ Architecture

This project follows **Domain-Driven Design (DDD)** with **Clean Architecture** principles:

```
lib/
├── core/               # Core utilities and DI
│   └── di/            # Dependency injection
├── domain/            # Business logic layer
│   ├── entities/      # Business objects
│   ├── repositories/  # Repository interfaces
│   └── usecases/      # Business use cases
├── data/              # Data layer
│   ├── datasources/   # Data sources (local/remote)
│   └── repositories/  # Repository implementations
└── presentation/      # Presentation layer
    ├── bloc/          # State management
    ├── screens/       # UI screens
    ├── widgets/       # Reusable widgets
    └── theme/         # App theming
```

## 📦 Features

- **Focus Timer**: Countdown timer for focus sessions
- **Gamification**: XP system with levels and progression
- **Focus Mode**: Distraction-free interface
- **Upgrade System**: Enhance your "stove" to earn XP faster
- **Beautiful UI**: Glass morphism effects with fire-themed aesthetics

## 🎯 Domain Layer

### Entities
- **Level**: Manages user level, XP, and progression
- **FocusSession**: Handles timer state and session management

### Use Cases
- **StartSessionUseCase**: Initiates a new focus session
- **UpdateLevelUseCase**: Updates user level based on earned XP

## 🔄 State Management (BLoC)

### Events
- `StartSessionEvent`: Start a new session
- `PauseSessionEvent`: Pause current session
- `ResumeSessionEvent`: Resume paused session
- `ToggleFocusModeEvent`: Toggle focus mode
- `UpdateXPEvent`: Add XP to current level
- `UpgradeStoveEvent`: Upgrade to earn more XP

### States
- `SessionInitial`: Initial state
- `SessionLoading`: Loading state
- `SessionRunning`: Active session
- `SessionPaused`: Paused session
- `SessionCompleted`: Completed session
- `SessionError`: Error state

## 🎨 UI Components

### Widgets
- **GlassContainer**: Glassmorphism effect container
- **TimerDisplay**: Digital timer with minutes and seconds
- **XPProgressBar**: Visual XP progress indicator
- **FocusModeButton**: Toggle focus mode
- **UpgradeButton**: Upgrade stove button

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd bonfire_app
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## 📱 Screens

### Main Fireplace Screen
- Displays countdown timer
- Shows current level and XP progress
- Focus mode toggle
- Upgrade button

## 🔧 Configuration

### Theme
The app uses a custom dark theme with:
- Primary color: `#EE6C2B` (orange/fire)
- Background: `#120A07` (dark brown)
- Glass effect with backdrop blur

### XP System
- Base XP rate: 12.5 XP/minute
- Level progression: Exponential (1000 + level × 100)
- XP updates every 5 seconds

## 🏛️ Design Patterns

1. **Repository Pattern**: Abstracts data sources
2. **Use Case Pattern**: Encapsulates business logic
3. **BLoC Pattern**: Manages state reactively
4. **Dependency Injection**: Using GetIt for IoC

## 📝 Code Quality

- **Equatable**: Value equality for entities and states
- **Dartz**: Functional programming with Either type
- **Type Safety**: Strong typing throughout
- **Separation of Concerns**: Clear layer boundaries

## 🔮 Future Enhancements

- [ ] Persistent storage (SharedPreferences/Hive)
- [ ] Statistics and analytics
- [ ] Multiple timer presets
- [ ] Sound effects and notifications
- [ ] Achievement system
- [ ] Social features

## 📄 License

This project is for educational purposes.
