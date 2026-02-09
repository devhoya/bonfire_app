import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/focus_session.dart';
import '../../domain/entities/level.dart';
import '../../domain/usecases/start_session_usecase.dart';
import '../../domain/usecases/update_level_usecase.dart';
import '../../domain/repositories/session_repository.dart';
import 'session_event.dart';
import 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final StartSessionUseCase startSessionUseCase;
  final UpdateLevelUseCase updateLevelUseCase;
  final SessionRepository repository;
  
  StreamSubscription<FocusSession>? _sessionSubscription;
  Timer? _xpTimer;

  SessionBloc({
    required this.startSessionUseCase,
    required this.updateLevelUseCase,
    required this.repository,
  }) : super(SessionInitial()) {
    on<StartSessionEvent>(_onStartSession);
    on<PauseSessionEvent>(_onPauseSession);
    on<ResumeSessionEvent>(_onResumeSession);
    on<StopSessionEvent>(_onStopSession);
    on<ToggleFocusModeEvent>(_onToggleFocusMode);
    on<SessionTickEvent>(_onSessionTick);
    on<UpdateXPEvent>(_onUpdateXP);
    on<UpgradeStoveEvent>(_onUpgradeStove);

    // Auto-start session
    add(StartSessionEvent(const Duration(minutes: 5)));
  }

  Future<void> _onStartSession(
    StartSessionEvent event,
    Emitter<SessionState> emit,
  ) async {
    emit(SessionLoading());

    final result = startSessionUseCase(event.duration);
    
    result.fold(
      (error) => emit(SessionError(error.toString())),
      (stream) {
        final levelResult = repository.getCurrentLevel();
        levelResult.fold(
          (error) => emit(SessionError(error.toString())),
          (level) {
            _sessionSubscription = stream.listen((session) {
              add(SessionTickEvent(session.remainingTime));
            });

            // Start XP timer
            _xpTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
              add(const UpdateXPEvent(1)); // Add 1 XP every 5 seconds (~12.5 XP/min)
            });

            emit(SessionRunning(
              session: FocusSession.initial(),
              level: level,
            ));
          },
        );
      },
    );
  }

  void _onPauseSession(
    PauseSessionEvent event,
    Emitter<SessionState> emit,
  ) {
    if (state is SessionRunning) {
      final currentState = state as SessionRunning;
      repository.pauseSession();
      _xpTimer?.cancel();
      emit(SessionPaused(
        session: currentState.session,
        level: currentState.level,
      ));
    }
  }

  void _onResumeSession(
    ResumeSessionEvent event,
    Emitter<SessionState> emit,
  ) {
    if (state is SessionPaused) {
      final currentState = state as SessionPaused;
      repository.resumeSession();
      
      _xpTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        add(const UpdateXPEvent(1));
      });
      
      emit(SessionRunning(
        session: currentState.session,
        level: currentState.level,
      ));
    }
  }

  void _onStopSession(
    StopSessionEvent event,
    Emitter<SessionState> emit,
  ) {
    _sessionSubscription?.cancel();
    _xpTimer?.cancel();
    repository.stopSession();
    emit(SessionInitial());
  }

  void _onToggleFocusMode(
    ToggleFocusModeEvent event,
    Emitter<SessionState> emit,
  ) {
    if (state is SessionRunning) {
      final currentState = state as SessionRunning;
      repository.toggleFocusMode();
      
      emit(currentState.copyWith(
        session: currentState.session.copyWith(
          isFocusMode: !currentState.session.isFocusMode,
        ),
      ));
    }
  }

  void _onSessionTick(
    SessionTickEvent event,
    Emitter<SessionState> emit,
  ) {
    if (state is SessionRunning) {
      final currentState = state as SessionRunning;
      final updatedSession = currentState.session.copyWith(
        remainingTime: event.remainingTime,
      );

      if (event.remainingTime.inSeconds <= 0) {
        _sessionSubscription?.cancel();
        _xpTimer?.cancel();
        emit(SessionCompleted(currentState.level));
      } else {
        emit(currentState.copyWith(session: updatedSession));
      }
    }
  }

  void _onUpdateXP(
    UpdateXPEvent event,
    Emitter<SessionState> emit,
  ) {
    if (state is SessionRunning) {
      final currentState = state as SessionRunning;
      final result = updateLevelUseCase(event.xp);
      
      result.fold(
        (error) => emit(SessionError(error.toString())),
        (updatedLevel) {
          emit(currentState.copyWith(level: updatedLevel));
        },
      );
    }
  }

  void _onUpgradeStove(
    UpgradeStoveEvent event,
    Emitter<SessionState> emit,
  ) {
    if (state is SessionRunning) {
      final currentState = state as SessionRunning;
      // Implement upgrade logic here
      // For now, just increase XP per minute
      final updatedLevel = currentState.level.copyWith(
        xpPerMinute: currentState.level.xpPerMinute + 2.5,
      );
      
      repository.saveLevel(updatedLevel);
      emit(currentState.copyWith(level: updatedLevel));
    }
  }

  @override
  Future<void> close() {
    _sessionSubscription?.cancel();
    _xpTimer?.cancel();
    return super.close();
  }
}
