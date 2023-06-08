import 'package:fatorfit/services/auth_service.dart';
import 'package:fatorfit/services/database_service.dart';
import 'package:fatorfit/theme/themecolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MiniProfilePage extends StatefulWidget {
  const MiniProfilePage({super.key});

  @override
  State<MiniProfilePage> createState() => _MiniProfilePageState();
}

enum GenderSelection {
  female,
  male,
}

class _MiniProfilePageState extends State<MiniProfilePage> {
  GenderSelection _selection = GenderSelection.female;
  final _userController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        const SizedBox(height: 10),
        Positioned(
          top: -15,
          child: Container(
            width: 60,
            height: 7,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              left: 38,
              right: 38,
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Profile Hoşgeldiniz",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                _buildName(_userController),
                const SizedBox(height: 15),
                _buildHeight(_heightController),
                const SizedBox(height: 15),
                _buildWeight(_weightController),
                const SizedBox(height: 15),
                _buildAge(_ageController),
                const SizedBox(height: 15),
                _buildGender(),
                const SizedBox(height: 15),
                _buildSaveButton(
                  context,
                  _ageController,
                  _userController,
                  _heightController,
                  _weightController,
                  _selection,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  _buildGender() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Cinsiyet:",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Expanded(
          flex: 1,
          child: RadioListTile<GenderSelection>(
            title: const Text(
              'Kadın',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            activeColor: Colors.black,
            value: GenderSelection.female,
            groupValue: _selection,
            onChanged: (GenderSelection? value) {
              setState(
                () {
                  _selection = value!;
                },
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: RadioListTile<GenderSelection>(
            title: const Text(
              'Erkek',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            activeColor: Colors.black,
            value: GenderSelection.male,
            groupValue: _selection,
            onChanged: (GenderSelection? value) {
              setState(
                () {
                  _selection = value!;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  _buildSaveButton(
    BuildContext context,
    TextEditingController ageController,
    TextEditingController userController,
    TextEditingController heightController,
    TextEditingController weightController,
    GenderSelection selection,
  ) {
    final authService = Provider.of<AuthService>(context);
    final mystream = authService.user;
    final age = ageController.text;
    final name = userController.text;
    final height = heightController.text;
    final weight = weightController.text;
    final gender = selection == GenderSelection.male ? "erkek" : "kadın";

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black87,
            child: IconButton(
              onPressed: () async {
                mystream?.listen(
                  (user) async {
                    if (user != null) {
                      final uid = user.userId;
                      final email = user.userMail;
                      final FirebaseRealtimeDatabase db =
                          FirebaseRealtimeDatabase(uid);
                      await db.saveUserInfo(
                        name,
                        gender,
                        int.parse(height),
                        int.parse(weight),
                        int.parse(age),
                        email!,
                      );
                    }
                  },
                );
              },
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 20),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black87,
            child: IconButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "profile");
              },
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_buildName(userController) {
  return TextField(
    controller: userController,
    decoration: InputDecoration(
      fillColor: AppColors.textFieldColor,
      filled: true,
      hintText: 'Adınız - Soyadınız',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );
}

//numerik kısım eklenecek
_buildHeight(heightController) {
  return TextFormField(
    controller: heightController,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
    ],
    decoration: InputDecoration(
      fillColor: AppColors.textFieldColor,
      filled: true,
      hintText: 'Boyunuz',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );
}

_buildWeight(weightController) {
  return TextField(
    controller: weightController,
    decoration: InputDecoration(
      fillColor: AppColors.textFieldColor,
      filled: true,
      hintText: 'Kilonuz',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );
}

_buildAge(ageController) {
  return TextField(
    controller: ageController,
    decoration: InputDecoration(
      fillColor: AppColors.textFieldColor,
      filled: true,
      hintText: 'Yaşınız',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );
}
