import 'package:dartz/dartz.dart';
import '../entities/level.dart';
import '../repositories/session_repository.dart';

class UpdateLevelUseCase {
  final SessionRepository repository;

  UpdateLevelUseCase(this.repository);

  Either<Exception, Level> call(int xpToAdd) {
    final currentLevelResult = repository.getCurrentLevel();
    
    return currentLevelResult.fold(
      (error) => Left(error),
      (currentLevel) {
        final updatedLevel = currentLevel.addXP(xpToAdd);
        repository.saveLevel(updatedLevel);
        return Right(updatedLevel);
      },
    );
  }
}
