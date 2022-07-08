abstract class AuthRepository {
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password});
  Future<void> signIn({required String email, required String password});
  Future<void> signInWithGoogle();
  Future<void> signOut();
}
