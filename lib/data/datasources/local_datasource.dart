import '../../domain/entities/level.dart';

abstract class LocalDataSource {
  Level getLevel();
  void saveLevel(Level level);
}

class LocalDataSourceImpl implements LocalDataSource {
  Level? _cachedLevel;

  @override
  Level getLevel() {
    return _cachedLevel ??
        const Level(
          currentLevel: 12,
          currentXP: 650,
          requiredXP: 1000,
          xpPerMinute: 12.5,
        );
  }

  @override
  void saveLevel(Level level) {
    _cachedLevel = level;
  }
}
