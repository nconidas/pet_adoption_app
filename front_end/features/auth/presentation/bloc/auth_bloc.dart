import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psso/core/error/exceptions.dart';
import 'package:psso/features/auth/domain/repositories/auth_repository.dart';
import 'package:psso/features/auth/presentation/bloc/auth_state.dart';

import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<SignInRequested>((event, emit) async {
      try {
        emit(Loading());
        await authRepository.signIn(
            email: event.email, password: event.password);
        emit(Authenticated());
      } on AuthException catch (e) {
        emit(Error(e.message));
        emit(UnAuthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      try {
        emit(Loading());
        await authRepository.signUpWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(Authenticated());
      } on AuthException catch (e) {
        emit(Error(e.message));
        emit(UnAuthenticated());
      }
    });

    on<GoogleSignInRequested>((event, emit) async {
      try {
        emit(Loading());
        await authRepository.signInWithGoogle();
        emit(Authenticated());
      } on AuthException catch (e) {
        emit(Error(e.message));
        emit(UnAuthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
  }
}
