import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatorfit/models/training_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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

  //mevcut user get isteği
  Stream<AppUser?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  //Email giriş fonksiyon
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

  //Email oluşturma fonksiyon
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

  //Email çıkış
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  //Google giriş fonksiyon
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

  //Google çıkış fonksiyon
  Future<void> signOutWithGoogle() async {
    await _googleSignIn.signOut();
  }

  //profil bilgilerini getiren fonksiyon
  Future<Map<String, dynamic>> getUserData() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        final ref = FirebaseDatabase.instance.ref();
        final dataSnapshot =
            await ref.child('users').child(currentUser.uid).get();
        final userData = dataSnapshot.value as Map<dynamic, dynamic>;
        if (userData != null) {
          int age = userData['age']; // Veri mevcut değilse boş değer
          String email = userData['email'];
          String fullName = userData['fullName'];
          String gender = userData['gender'];
          int height = userData['height'];
          int weight = userData['weight'];
          // Verileri bir harita olarak döndür
          final userMap = {
            'age': age,
            'email': email,
            'fullName': fullName,
            'gender': gender,
            'height': height,
            'weight': weight,
          };
          return userMap;
        } else {
          print('Kullanıcı verileri bulunamadı');
        }
      }
    } catch (e) {
      print('Veri getirme hatası: $e');
      return {
        'age': '',
        'email': '',
        'fullName': '',
        'gender': '',
        'height': '',
        'weight': '',
      };
    }
    // Hata durumunda veya veri bulunamadığında null döndür
    return Future.value(null);
  }

  //mevcut günü alan fonksiyon
  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month}-${now.day}";
    return formattedDate;
  }

  //filtreli program ekleme fonksiyonu
  Future<void> performSetOperation(Map<String, dynamic> programs,
      {double progresValue = 0.0}) async {
    final currentUser = _firebaseAuth.currentUser;
    String currentDate = getCurrentDate();

    // Training koleksiyonuna erişim
    CollectionReference trainingCollection =
        FirebaseFirestore.instance.collection("Training");

    // Bugünün dökümanını al
    DocumentReference currentDayDoc = trainingCollection.doc(currentDate);
    DocumentSnapshot currentDaySnapshot = await currentDayDoc.get();

    try {
      // Eğer bugün için bir döküman yoksa, yeni bir döküman oluştur
      if (!currentDaySnapshot.exists) {
        await currentDayDoc.set(
          {
            'day': currentDate,
          },
        );
        currentDaySnapshot = await currentDayDoc.get();
      }
      //Mevcut kullanıcı varlığı kontrolü
      if (currentUser != null) {
        DocumentReference userIdDoc =
            currentDayDoc.collection("userBase").doc(currentUser.uid);
        DocumentSnapshot userIdSnapshot = await userIdDoc.get();
        if (!userIdSnapshot.exists) {
          await userIdDoc.set(
            {
              'id': currentUser.uid,
            },
          );
        }
        //her program için bir döküman oluştur
        for (var data in programs.entries) {
          DocumentReference programNameDoc =
              userIdDoc.collection("programs").doc(data.key);
          DocumentSnapshot programNameSnapshot = await programNameDoc.get();
          //Döküman varsa ilgili hedef ve yapılan değeri gir
          if (programNameSnapshot.exists) {
            await programNameDoc.set(
              {
                'target': data.value,
                'progresValue': progresValue,
              },
            );
          }
          //Döküman yoksa program ismiyle oluştur yukarıdaki işlemi yap
          await programNameDoc.set(
            {
              "programName": data.key,
              "target": data.value,
              "progresValue": progresValue,
            },
          );
        }
      }
    } catch (e) {
      print("Set etme sırasında bir sorun oluştu hata kodu ${e}");
    }
  }

  //yapılan veriyi kaydetme
  Future<void> progresSetOperation(Map<String, dynamic> progres) async {
    final currentUser = _firebaseAuth.currentUser;
    String currentDate = getCurrentDate();

    // Training koleksiyonuna erişim
    CollectionReference trainingCollection =
        FirebaseFirestore.instance.collection("Training");

    // Bugünün dökümanını al
    DocumentReference currentDayDoc = trainingCollection.doc(currentDate);
    DocumentSnapshot currentDaySnapshot = await currentDayDoc.get();

    try {
      // Eğer bugün için bir döküman yoksa, yeni bir döküman oluştur
      if (!currentDaySnapshot.exists) {
        await currentDayDoc.set(
          {
            'day': currentDate,
          },
        );
        currentDaySnapshot = await currentDayDoc.get();
      }
      if (currentUser != null) {
        DocumentReference userIdDoc =
            currentDayDoc.collection("userBase").doc(currentUser.uid);
        DocumentSnapshot userIdSnapshot = await userIdDoc.get();
        if (!userIdSnapshot.exists) {
          await userIdDoc.set(
            {
              'id': currentUser.uid,
            },
          );
        }
        //her program için bir döküman oluştur
        for (var data in progres.entries) {
          DocumentReference programNameDoc =
              userIdDoc.collection("programs").doc(data.key);
          DocumentSnapshot programNameSnapshot = await programNameDoc.get();
          //Döküman varsa ilgili yapılan değeri kaydet
          if (programNameSnapshot.exists) {
            await programNameDoc.update(
              {
                'progresValue': data.value,
              },
            );
          }
          //Döküman yoksa program ismiyle oluştur yukarıdaki işlemi yap
          await programNameDoc.update(
            {
              "programName": data.key,
              "progresValue": data.value,
            },
          );
        }
      }
    } catch (e) {
      print("Set etme sırasında bir sorun oluştu hata kodu ${e}");
    }
  }

  //program getirme fonksiyonu
  Future<List<TrainingDetailModel>> getUserPrograms() async {
    String currentDate = getCurrentDate();
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      final CollectionReference trainingCollection = FirebaseFirestore.instance
          .collection('Training')
          .doc(currentDate)
          .collection('userBase')
          .doc(currentUser.uid)
          .collection('programs');
      QuerySnapshot dataSnapshot = await trainingCollection.get();
      List<TrainingDetailModel> programs = dataSnapshot.docs.map(
        (doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return TrainingDetailModel(
              programName: data['programName'] as String?,
              target: data['target'] as int?,
              progresValue: data['progresValue'] as double);
        },
      ).toList();
      return programs;
    }
    return Future.value(null);
  }

  //program silme fonksiyonu
  Future<void> deleteProgram(String? programName) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      final currentDate = getCurrentDate();
      final DocumentReference programRef = FirebaseFirestore.instance
          .collection('Training')
          .doc(currentDate)
          .collection('userBase')
          .doc(currentUser.uid)
          .collection('programs')
          .doc(programName);
      await programRef.delete();
    }
  }

  //gelişim geçmiş fonksiyonu
  Future<Map<String, List<TrainingDetailModel>>>
      getAllDatesAndUserPrograms() async {
    final currentUser = _firebaseAuth.currentUser;
    final CollectionReference trainingCollection =
        FirebaseFirestore.instance.collection('Training');
    QuerySnapshot snapshot = await trainingCollection.get();
    Map<String, List<TrainingDetailModel>> datesAndPrograms = {};

    if (snapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        String date = doc.id;
        final DocumentReference userProgramRef = trainingCollection
            .doc(date)
            .collection('userBase')
            .doc(currentUser?.uid);

        DocumentSnapshot userProgramSnapshot = await userProgramRef.get();

        if (userProgramSnapshot.exists) {
          List<TrainingDetailModel> programs = [];

          QuerySnapshot programSnapshot =
              await userProgramRef.collection('programs').get();
          if (programSnapshot.docs.isNotEmpty) {
            for (QueryDocumentSnapshot programDoc in programSnapshot.docs) {
              Map<String, dynamic>? programData =
                  programDoc.data() as Map<String, dynamic>?;
              if (programData != null) {
                double? progresValue = programData['progresValue'] as double?;
                if (progresValue != null) {
                  TrainingDetailModel program = TrainingDetailModel(
                    programName: programData['programName'] as String?,
                    target: programData['target'] as int?,
                    progresValue: progresValue,
                  );
                  programs.add(program);
                }
              }
            }
          }
          print(programs);
          datesAndPrograms[date] = programs;
        }
      }
    }
    return datesAndPrograms;
  }
}
