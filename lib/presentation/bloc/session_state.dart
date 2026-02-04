import 'package:equatable/equatable.dart';
import '../../domain/entities/focus_session.dart';
import '../../domain/entities/level.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object?> get props => [];
}

class SessionInitial extends SessionState {}

class SessionLoading extends SessionState {}

class SessionRunning extends SessionState {
  final FocusSession session;
  final Level level;

  const SessionRunning({
    required this.session,
    required this.level,
  });

  SessionRunning copyWith({
    FocusSession? session,
    Level? level,
  }) {
    return SessionRunning(
      session: session ?? this.session,
      level: level ?? this.level,
    );
  }

  @override
  List<Object?> get props => [session, level];
}

class SessionPaused extends SessionState {
  final FocusSession session;
  final Level level;

  const SessionPaused({
    required this.session,
    required this.level,
  });

  @override
  List<Object?> get props => [session, level];
}

class SessionCompleted extends SessionState {
  final Level level;

  const SessionCompleted(this.level);

  @override
  List<Object?> get props => [level];
}

class SessionError extends SessionState {
  final String message;

  const SessionError(this.message);

  @override
  List<Object?> get props => [message];
}
