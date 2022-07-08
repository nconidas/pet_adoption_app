import 'package:psso/features/auth/domain/repositories/auth_repository.dart';

class SignIn {
  final AuthRepository repository;

  SignIn(this.repository);

  Future<void> call({required email, required password}) async {
    repository.signIn(email: email, password: password);
  }
}

class SignUpWithEmailAndPassword {
  final AuthRepository repository;

  SignUpWithEmailAndPassword(this.repository);

  Future<void> call({required email, required password}) async {
    repository.signUpWithEmailAndPassword(email: email, password: password);
  }
}

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<void> call() async {
    repository.signInWithGoogle();
  }
}

class SignOut {
  final AuthRepository repository;

  SignOut(this.repository);

  Future<void> call() async {
    repository.signOut();
  }
}
