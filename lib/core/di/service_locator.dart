import 'package:get_it/get_it.dart';
import '../data/datasources/local_datasource.dart';
import '../data/repositories/session_repository_impl.dart';
import '../domain/repositories/session_repository.dart';
import '../domain/usecases/start_session_usecase.dart';
import '../domain/usecases/update_level_usecase.dart';
import '../presentation/bloc/session_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Data Sources
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<SessionRepository>(
    () => SessionRepositoryImpl(getIt<LocalDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton(
    () => StartSessionUseCase(getIt<SessionRepository>()),
  );
  
  getIt.registerLazySingleton(
    () => UpdateLevelUseCase(getIt<SessionRepository>()),
  );

  // BLoC
  getIt.registerFactory(
    () => SessionBloc(
      startSessionUseCase: getIt<StartSessionUseCase>(),
      updateLevelUseCase: getIt<UpdateLevelUseCase>(),
      repository: getIt<SessionRepository>(),
    ),
  );
}
