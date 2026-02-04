import 'dart:async';
import 'package:dartz/dartz.dart';
import '../../domain/entities/focus_session.dart';
import '../../domain/entities/level.dart';
import '../../domain/repositories/session_repository.dart';
import '../datasources/local_datasource.dart';

class SessionRepositoryImpl implements SessionRepository {
  final LocalDataSource localDataSource;
  StreamController<FocusSession>? _sessionController;
  Timer? _timer;
  FocusSession? _currentSession;

  SessionRepositoryImpl(this.localDataSource);

  @override
  Either<Exception, Stream<FocusSession>> startSession(Duration duration) {
    try {
      _currentSession = FocusSession(
        remainingTime: duration,
        totalDuration: duration,
        status: SessionStatus.running,
      );

      _sessionController = StreamController<FocusSession>.broadcast();
      _sessionController!.add(_currentSession!);

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_currentSession != null && _currentSession!.status == SessionStatus.running) {
          _currentSession = _currentSession!.tick();
          _sessionController!.add(_currentSession!);

          if (_currentSession!.status == SessionStatus.completed) {
            timer.cancel();
          }
        }
      });

      return Right(_sessionController!.stream);
    } catch (e) {
      return Left(Exception('Failed to start session: $e'));
    }
  }

  @override
  Either<Exception, Unit> pauseSession() {
    try {
      if (_currentSession != null) {
        _currentSession = _currentSession!.copyWith(status: SessionStatus.paused);
        _sessionController?.add(_currentSession!);
      }
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Failed to pause session: $e'));
    }
  }

  @override
  Either<Exception, Unit> resumeSession() {
    try {
      if (_currentSession != null) {
        _currentSession = _currentSession!.copyWith(status: SessionStatus.running);
        _sessionController?.add(_currentSession!);
      }
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Failed to resume session: $e'));
    }
  }

  @override
  Either<Exception, Unit> stopSession() {
    try {
      _timer?.cancel();
      _sessionController?.close();
      _currentSession = null;
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Failed to stop session: $e'));
    }
  }

  @override
  Either<Exception, Unit> toggleFocusMode() {
    try {
      if (_currentSession != null) {
        _currentSession = _currentSession!.copyWith(
          isFocusMode: !_currentSession!.isFocusMode,
        );
        _sessionController?.add(_currentSession!);
      }
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Failed to toggle focus mode: $e'));
    }
  }

  @override
  Either<Exception, Level> getCurrentLevel() {
    try {
      final level = localDataSource.getLevel();
      return Right(level);
    } catch (e) {
      return Left(Exception('Failed to get current level: $e'));
    }
  }

  @override
  Either<Exception, Unit> saveLevel(Level level) {
    try {
      localDataSource.saveLevel(level);
      return const Right(unit);
    } catch (e) {
      return Left(Exception('Failed to save level: $e'));
    }
  }

  void dispose() {
    _timer?.cancel();
    _sessionController?.close();
  }
}
