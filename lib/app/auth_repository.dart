import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class IAuthRepository {
  Future<User?> getCurrentUser();
  Future<User?> registerWithandPassword(
      {required String email, required String password});
  Future<User?> loginWithEmailandPassword(
      {required String email, required String password});
  Future<void> signOut();
}

class AuthRepository extends IAuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  late final GoogleSignInAccount? _googleUser;
  GoogleSignInAccount get user => _googleUser!;

  Future<void> googleSignIn() async {
    try {
      _googleUser = await GoogleSignIn().signIn();
      //get auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await _googleUser!.authentication;
      //creating a new credentials
      final credentials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw e.code.toString();
    }
  }

  AuthRepository({required this.auth});
  @override
  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }

  @override
  Future<User?> registerWithandPassword(
      {required String email, required String password}) async {
    try {
      var user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return user.user;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      log('$e');
    }
  }

  @override
  Future<User?> loginWithEmailandPassword(
      {required String email, required String password}) async {
    try {
      var user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user.user;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      log('$e');
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
    return;
  }
}
