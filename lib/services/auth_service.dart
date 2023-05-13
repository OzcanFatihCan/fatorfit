import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AppUser? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return AppUser(user.uid, user.email);
  }

  Stream<AppUser?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<AppUser?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //giriş başarılı
    } on FirebaseAuthException catch (e) {
      //giriş hatalı
      print(e.code);
    }
  }

  Future<AppUser?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<AppUser?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutWithGoogle() async {
    await _googleSignIn.signOut();
  }

  static String getErrorMessageFromException(dynamic error) {
    String errorMsg = '';
    switch (error.code) {
      case 'user-not-found':
        errorMsg = 'Kullanıcı bulunamadı';
        break;
      case 'wrong-password':
        errorMsg = 'Yanlış parola';
        break;
      default:
        errorMsg = 'Giriş yaparken bir hata oluştu';
        break;
    }
    return errorMsg;
  }
}
