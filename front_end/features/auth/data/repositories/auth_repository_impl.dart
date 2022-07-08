import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:psso/core/error/exceptions.dart';
import 'package:psso/core/network/network_info.dart';

import '../../domain/repositories/auth_repository.dart';

const String USER_NOT_FOUND_MESSAGE = 'No user found for that email.';
const String WRONG_PASSWORD_MESSAGE = 'Wrong password provided for that user';
const String WEAK_PASSWORD_MESSAGE = 'The provided password is too weak';
const String EMAIL_IN_USE_MESSAGE = 'Account already registered to that email';

class AuthRepositoryImpl implements AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({required this.networkInfo});

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      print('$email $password');
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        throw AuthException(USER_NOT_FOUND_MESSAGE);
      } else if (e.code == 'wrong-password') {
        throw AuthException(WRONG_PASSWORD_MESSAGE);
      } else {
        throw AuthException(e.toString());
      }
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException(WEAK_PASSWORD_MESSAGE);
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(EMAIL_IN_USE_MESSAGE);
      } else {
        throw AuthException(e.code);
      }
    } catch (e) {
      throw AuthException(e.toString());
    }
  }
}
