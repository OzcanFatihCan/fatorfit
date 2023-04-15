import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  /* snackbar için kontrol edilecek
  String _isError = "";
  String _errorMessage = "";

  //diğer sayfalardan çağırma fonksiyonu
  String get isError => _isError;
  String get errorMessage => _errorMessage;
  */

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

      if (e.code == 'user-not-found') {
        print("Kullanıcı bulunamadı");
      } else if (e.code == 'wrong-password') {
        print("Hatalı şifre girişi");
      }
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
}
