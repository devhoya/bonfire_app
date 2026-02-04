import 'package:dartz/dartz.dart';
import '../entities/focus_session.dart';
import '../entities/level.dart';

abstract class SessionRepository {
  Either<Exception, Stream<FocusSession>> startSession(Duration duration);
  Either<Exception, Unit> pauseSession();
  Either<Exception, Unit> resumeSession();
  Either<Exception, Unit> stopSession();
  Either<Exception, Unit> toggleFocusMode();
  
  Either<Exception, Level> getCurrentLevel();
  Either<Exception, Unit> saveLevel(Level level);
}
