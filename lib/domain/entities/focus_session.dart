import 'package:equatable/equatable.dart';

enum SessionStatus { idle, running, paused, completed }

class FocusSession extends Equatable {
  final Duration remainingTime;
  final Duration totalDuration;
  final SessionStatus status;
  final bool isFocusMode;
  final int earnedXP;

  const FocusSession({
    required this.remainingTime,
    required this.totalDuration,
    required this.status,
    this.isFocusMode = false,
    this.earnedXP = 0,
  });

  factory FocusSession.initial() {
    return const FocusSession(
      remainingTime: Duration(minutes: 45, seconds: 12),
      totalDuration: Duration(minutes: 45, seconds: 12),
      status: SessionStatus.running,
      isFocusMode: false,
      earnedXP: 0,
    );
  }

  FocusSession copyWith({
    Duration? remainingTime,
    Duration? totalDuration,
    SessionStatus? status,
    bool? isFocusMode,
    int? earnedXP,
  }) {
    return FocusSession(
      remainingTime: remainingTime ?? this.remainingTime,
      totalDuration: totalDuration ?? this.totalDuration,
      status: status ?? this.status,
      isFocusMode: isFocusMode ?? this.isFocusMode,
      earnedXP: earnedXP ?? this.earnedXP,
    );
  }

  FocusSession tick() {
    if (status != SessionStatus.running) return this;
    
    final newRemaining = remainingTime - const Duration(seconds: 1);
    if (newRemaining.isNegative) {
      return copyWith(
        remainingTime: Duration.zero,
        status: SessionStatus.completed,
      );
    }
    
    return copyWith(remainingTime: newRemaining);
  }

  FocusSession addXP(int xp) {
    return copyWith(earnedXP: earnedXP + xp);
  }

  @override
  List<Object?> get props => [
        remainingTime,
        totalDuration,
        status,
        isFocusMode,
        earnedXP,
      ];
}
