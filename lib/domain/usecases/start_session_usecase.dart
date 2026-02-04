import 'package:dartz/dartz.dart';
import '../entities/focus_session.dart';
import '../repositories/session_repository.dart';

class StartSessionUseCase {
  final SessionRepository repository;

  StartSessionUseCase(this.repository);

  Either<Exception, Stream<FocusSession>> call(Duration duration) {
    return repository.startSession(duration);
  }
}
