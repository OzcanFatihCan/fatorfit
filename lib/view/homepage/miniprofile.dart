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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GenderSelection _selection = GenderSelection.female;
  final _userController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _userController.clear();
    _userController.dispose();
    _heightController.clear;
    _heightController.dispose();
    _weightController.clear();
    _weightController.dispose();
    _ageController.clear();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        const SizedBox(height: 10),
        TextButton(
          onPressed: () async {},
          child: const Text(
            "Profil",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(1000, 58, 67, 76),
            ),
          ),
        ),
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
        Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.10,
              left: 38,
              right: 38),
          child: Column(children: [
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
            _buildSaveButton(context, _ageController, _userController,
                _heightController, _weightController, _selection)
          ]),
        )
      ],
    );
  }

  _buildGender() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Cinsiyet:",
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 87, 107, 161)),
        ),
        Expanded(
          child: RadioListTile<GenderSelection>(
            title: const Text(
              'Kadın',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xff4c505b),
              ),
            ),
            activeColor: Colors.black,
            value: GenderSelection.female,
            groupValue: _selection,
            onChanged: (GenderSelection? value) {
              setState(() {
                _selection = value!;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<GenderSelection>(
            title: const Text(
              'Erkek',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xff4c505b),
              ),
            ),
            activeColor: Colors.black,
            value: GenderSelection.male,
            groupValue: _selection,
            onChanged: (GenderSelection? value) {
              setState(() {
                _selection = value!;
              });
            },
          ),
        ),
      ],
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
        )),
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
        )),
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
        )),
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
        )),
  );
}

_buildSaveButton(BuildContext context, _ageController, _userController,
    _heightController, _weightController, _selection) {
  final authService = Provider.of<AuthService>(context);
  final mystream = authService.user;
  final age = _ageController.text;
  final name = _userController.text;
  final height = _heightController.text;
  final weight = _weightController.text;
  final gender = _selection == GenderSelection.male ? "erkek" : "kadın";

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      //kaydetme
      CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.bottomNavBarColor,
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
                    uid,
                  );
                }
              },
            );
          },
          icon: const Icon(Icons.save),
          color: Colors.white,
        ),
      ),
      const SizedBox(width: 25),
      //profil
      CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.bottomNavBarColor,
        child: IconButton(
          onPressed: () async {
            await Navigator.pushNamed(context, "profile");
          },
          icon: const Icon(Icons.person),
          color: Colors.white,
        ),
      ),
    ],
  );
}
