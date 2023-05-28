import 'dart:async';

import 'package:fatorfit/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRealtimeDatabase {
  final String uid;

  FirebaseRealtimeDatabase(this.uid);

  Future<void> saveUserInfo(String fullName, String gender, int height,
      int weight, int age, String email) async {
    try {
      final DatabaseReference _db =
          FirebaseDatabase.instance.ref().child('users/$uid');
      await _db.set({
        'age': age,
        'email': email,
        'fullName': fullName,
        'gender': gender,
        'height': height,
        'weight': weight,
      });
    } catch (e) {
      print('Error saving user info: $e');
    }
  }

  // Future<UserModel?> getUserDataFromDatabase(String uid) async {
  //   try {
  //     final ref = FirebaseDatabase.instance.ref();
  //     final snapshot = await ref.child('users').child(uid).get();
  //     final data = snapshot.value as Map<dynamic, dynamic>;
  //     if (data != null) {
  //       return UserModel.fromJson(Map<String, dynamic>.from(data));
  //     }
  //     return null;
  //   } catch (error) {
  //     print('Hata: $error');
  //     return null;
  //   }
  // }
}
