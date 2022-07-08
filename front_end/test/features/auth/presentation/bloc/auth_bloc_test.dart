import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:psso/core/error/exceptions.dart';
import 'package:psso/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:psso/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:psso/features/auth/presentation/bloc/auth_event.dart';
import 'package:psso/features/auth/presentation/bloc/auth_state.dart';

import 'auth_bloc_test.mocks.dart';

// class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

@GenerateMocks([AuthRepositoryImpl])
void main() {
  late AuthBloc authBloc;
  late MockAuthRepositoryImpl mockAuthRepositoryImpl;
  const tExceptionMessage = 'Test failure';
  const email = 'test@gmail.com';
  const password = '12345';

  setUp(() {
    mockAuthRepositoryImpl = MockAuthRepositoryImpl();
    authBloc = AuthBloc(authRepository: mockAuthRepositoryImpl);
  });

  test('initial state should be unAuthenticated', () {
    expect(authBloc.state, UnAuthenticated());
  });

  group('SignIn', () {
    final succeesExpected = [Loading(), Authenticated()];
    final failureExpected = [
      Loading(),
      Error(tExceptionMessage),
      UnAuthenticated()
    ];
    blocTest<AuthBloc, AuthState>(
      'should emit [Loding, Authenticated when the sign in succeeds',
      build: () => authBloc,
      act: (bloc) => bloc.add(SignInRequested(email, password)),
      expect: () => succeesExpected,
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [Loding, Error, UnAuthenticated] when the sign in Fails',
      setUp: () {
        when(mockAuthRepositoryImpl.signIn(
                email: anyNamed('email'), password: anyNamed('password')))
            .thenThrow(AuthException(tExceptionMessage));
      },
      build: () => authBloc,
      act: (bloc) async => bloc.add(SignInRequested(email, password)),
      expect: () => failureExpected,
    );
  });

  group('SignUp', () {
    final succeesExpected = [Loading(), Authenticated()];
    final failureExpected = [
      Loading(),
      Error(tExceptionMessage),
      UnAuthenticated()
    ];
    blocTest<AuthBloc, AuthState>(
      'should emit [Loding, Authenticated when the sign up succeeds',
      build: () => authBloc,
      act: (bloc) => bloc.add(SignUpRequested(email, password)),
      expect: () => succeesExpected,
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [Loding, Error, UnAuthenticated] when the sign up Fails',
      setUp: () {
        when(mockAuthRepositoryImpl.signUpWithEmailAndPassword(
                email: anyNamed('email'), password: anyNamed('password')))
            .thenThrow(AuthException(tExceptionMessage));
      },
      build: () => authBloc,
      act: (bloc) async => bloc.add(SignUpRequested(email, password)),
      expect: () => failureExpected,
    );
  });

  group('GoogleSignIn', () {
    final succeesExpected = [Loading(), Authenticated()];
    final failureExpected = [
      Loading(),
      Error(tExceptionMessage),
      UnAuthenticated()
    ];
    blocTest<AuthBloc, AuthState>(
      'should emit [Loding, Authenticated when the Google sign in succeeds',
      build: () => authBloc,
      act: (bloc) => bloc.add(GoogleSignInRequested()),
      expect: () => succeesExpected,
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [Loding, Error, UnAuthenticated] when the google sign in Fails',
      setUp: () {
        when(mockAuthRepositoryImpl.signInWithGoogle())
            .thenThrow(AuthException(tExceptionMessage));
      },
      build: () => authBloc,
      act: (bloc) async => bloc.add(GoogleSignInRequested()),
      expect: () => failureExpected,
    );
  });

  group('SignOut', () {
    final succeesExpected = [Loading(), UnAuthenticated()];

    blocTest<AuthBloc, AuthState>(
      'should emit [Loding, UnAuthenticated when the Google sign out succeeds',
      build: () => authBloc,
      act: (bloc) => bloc.add(SignOutRequested()),
      expect: () => succeesExpected,
    );
  });
}
