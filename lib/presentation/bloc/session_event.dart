import 'package:equatable/equatable.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object?> get props => [];
}

class StartSessionEvent extends SessionEvent {
  final Duration duration;

  const StartSessionEvent(this.duration);

  @override
  List<Object?> get props => [duration];
}

class PauseSessionEvent extends SessionEvent {}

class ResumeSessionEvent extends SessionEvent {}

class StopSessionEvent extends SessionEvent {}

class ToggleFocusModeEvent extends SessionEvent {}

class SessionTickEvent extends SessionEvent {
  final Duration remainingTime;

  const SessionTickEvent(this.remainingTime);

  @override
  List<Object?> get props => [remainingTime];
}

class UpdateXPEvent extends SessionEvent {
  final int xp;

  const UpdateXPEvent(this.xp);

  @override
  List<Object?> get props => [xp];
}

class UpgradeStoveEvent extends SessionEvent {}
