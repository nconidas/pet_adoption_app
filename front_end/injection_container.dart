import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:psso/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:psso/features/auth/domain/repositories/auth_repository.dart';
import 'package:psso/features/auth/domain/use_cases/auth.dart';
import 'package:psso/features/auth/presentation/bloc/auth_bloc.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features- Auth
  // Bloc
  sl.registerFactory(
    () => AuthBloc(authRepository: sl()),
  );
  // UseCases
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => SignUpWithEmailAndPassword(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(networkInfo: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
