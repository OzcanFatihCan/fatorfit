import 'dart:async';

import 'package:fatorfit/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRealtimeDatabase {
  final String uid;
  FirebaseRealtimeDatabase(this.uid);
  Future<void> saveUserInfo(String fullName, String gender, int height,
      int weight, int age, String email, String uid) async {
    try {
      final DatabaseReference _db =
          FirebaseDatabase.instance.ref().child('users/$uid');
      await _db.set({
        'age': age,
        'email': email,
        'fullName': fullName,
        'gender': gender,
        'height': height,
        'uid': uid,
        'weight': weight,
      });
    } catch (e) {
      print('Error saving user info: $e');
    }
  }

  Future<UserModel> getUserInfo(String uid) async {
    final completer = Completer<UserModel>();

    FirebaseDatabase.instance.ref().child('users/$uid').onValue.listen((event) {
      final data = event.snapshot.value as Map;
      if (data != null) {
        final user = UserModel.fromJson(Map<String, dynamic>.from(data));
        completer.complete(user);
      }
    }, onError: (Object o) {
      final error = o.toString();
      completer.completeError(error);
    });

    return completer.future;
  }
}
