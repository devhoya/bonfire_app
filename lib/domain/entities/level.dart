import 'package:equatable/equatable.dart';

class Level extends Equatable {
  final int currentLevel;
  final int currentXP;
  final int requiredXP;
  final double xpPerMinute;

  const Level({
    required this.currentLevel,
    required this.currentXP,
    required this.requiredXP,
    required this.xpPerMinute,
  });

  double get progress => currentXP / requiredXP;

  Level copyWith({
    int? currentLevel,
    int? currentXP,
    int? requiredXP,
    double? xpPerMinute,
  }) {
    return Level(
      currentLevel: currentLevel ?? this.currentLevel,
      currentXP: currentXP ?? this.currentXP,
      requiredXP: requiredXP ?? this.requiredXP,
      xpPerMinute: xpPerMinute ?? this.xpPerMinute,
    );
  }

  Level addXP(int xp) {
    final newXP = currentXP + xp;
    if (newXP >= requiredXP) {
      return Level(
        currentLevel: currentLevel + 1,
        currentXP: newXP - requiredXP,
        requiredXP: _calculateRequiredXP(currentLevel + 1),
        xpPerMinute: xpPerMinute,
      );
    }
    return copyWith(currentXP: newXP);
  }

  int _calculateRequiredXP(int level) {
    return 1000 + (level * 100);
  }

  @override
  List<Object?> get props => [currentLevel, currentXP, requiredXP, xpPerMinute];
}
