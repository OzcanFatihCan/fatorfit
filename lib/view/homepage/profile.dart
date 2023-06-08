import 'package:fatorfit/services/auth_service.dart';
import 'package:fatorfit/theme/themecolor.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthService().getUserData();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: AppColors.appbarColor),
          ),
          title: const Text(
            "Profil",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          toolbarHeight: 40,
          toolbarOpacity: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0.00,
          backgroundColor: const Color.fromARGB(255, 22, 175, 196),
        ),
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          clipBehavior: Clip.none,
          children: [
            const SizedBox(height: 10),
            userDataWidget(authService, context),
          ],
        ),
      ),
    );
  }
}

Widget userDataWidget(
    Future<Map<String, dynamic>?> authService, BuildContext context) {
  return FutureBuilder<Map<String, dynamic>?>(
    future: authService,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        ); // Veriler yüklenene kadar bekleyen bir gösterge
      } else if (snapshot.hasError) {
        return Text('Veri getirme hatası: ${snapshot.error}');
      } else {
        final userData = snapshot.data!;
        if (userData != null) {
          final age = userData['age'];
          final email = userData['email'];
          final fullName = userData['fullName'];
          final gender = userData['gender'];
          final height = userData['height'];
          final weight = userData['weight'];

          return Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.10,
              left: 25,
              right: 25,
            ),
            child: Column(
              children: [
                Text(
                  "Hoşgeldiniz: $email",
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                _buildName(fullName),
                _buildHeight(height),
                _buildWeight(weight),
                _buildAge(age),
                _buildGender(gender),
                const SizedBox(height: 100),
                _buildTrainingGo(context),
              ],
            ),
          );
        } else {
          return const Text('Kullanıcı verileri bulunamadı');
        }
      }
    },
  );
}

_buildName(fullName) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    color: Colors.grey.shade400,
    child: SizedBox(
      width: 400,
      height: 60,
      child: Center(
        child: Text(
          'Adınız: $fullName ',
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

_buildGender(gender) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    color: Colors.grey.shade400,
    child: SizedBox(
      width: 500,
      height: 60,
      child: Center(
        child: Text(
          'Cinsiyet: $gender',
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

//numerik kısım eklenecek
_buildHeight(height) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    color: AppColors.appbarColor,
    child: SizedBox(
      width: 500,
      height: 60,
      child: Center(
        child: Text(
          'Boyunuz: $height',
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

_buildWeight(weight) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    color: Colors.grey.shade400,
    child: SizedBox(
      width: 500,
      height: 60,
      child: Center(
        child: Text(
          'Kilonuz: $weight',
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

_buildAge(age) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    color: AppColors.appbarColor,
    child: SizedBox(
      width: 500,
      height: 60,
      child: Center(
        child: Text(
          'Yaşınız: $age',
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

_buildTrainingGo(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.height * 0.65,
    child: ElevatedButton(
      onPressed: () async {
        await Navigator.pushNamed(context, "detailtraining");
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 15.0,
        ),
        side: const BorderSide(color: Colors.black),
        backgroundColor: AppColors.bottomNavBarColor,
      ),
      child: const Text(
        "Program",
        style: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
