import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRealtimeDatabase {
  final String uid;

  FirebaseRealtimeDatabase(this.uid);

  Future<void> saveUserInfo(String fullName, String gender, int height,
      int weight, int age, String email) async {
    try {
      final DatabaseReference db =
          FirebaseDatabase.instance.ref().child('users/$uid');
      await db.set({
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
}
