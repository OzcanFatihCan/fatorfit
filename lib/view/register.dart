import 'package:flutter/material.dart';

import '../theme/themecolor.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum GenderSelection {
  female,
  male,
}

class _RegisterPageState extends State<RegisterPage> {
  GenderSelection _selection = GenderSelection.female;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            //assets klasorunden arka plana aktarma alanı
            image: AssetImage('assets/register.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.37,
                  left: 38,
                  right: 38),
              child: Column(
                children: [
                  buildRegisterText(),
                  const SizedBox(height: 5),
                  buildRegisterAccountId(),
                  const SizedBox(height: 15),
                  buildRegisterPassword(),
                  const SizedBox(height: 15),
                  buildRegisterHeight(),
                  const SizedBox(height: 15),
                  buildRegisterWeight(),
                  const SizedBox(height: 15),
                  buildRegisterAge(),
                  const SizedBox(height: 15),
                  buildRegisterGender(),
                  const SizedBox(height: 5),
                  buildRegister(),
                  const SizedBox(height: 10)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  buildRegisterGender() {
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

buildRegisterText() {
  return const Text(
    "Hesap Oluştur",
    style: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
  );
}

buildRegisterAccountId() {
  return TextField(
    decoration: InputDecoration(
        fillColor: AppColors.textFieldColor,
        filled: true,
        hintText: 'Kullanıcı Adı veya E-Mail',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        )),
  );
}

buildRegisterPassword() {
  return TextField(
    obscureText: true,
    decoration: InputDecoration(
        fillColor: AppColors.textFieldColor,
        filled: true,
        hintText: 'Şifre',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        )),
  );
}

buildRegisterHeight() {
  return TextField(
    decoration: InputDecoration(
        fillColor: AppColors.textFieldColor,
        filled: true,
        hintText: 'Boyunuz',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        )),
  );
}

buildRegisterWeight() {
  return TextField(
    decoration: InputDecoration(
        fillColor: AppColors.textFieldColor,
        filled: true,
        hintText: 'Kilonuz',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        )),
  );
}

buildRegisterAge() {
  return TextField(
    decoration: InputDecoration(
        fillColor: AppColors.textFieldColor,
        filled: true,
        hintText: 'Yaşınız',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        )),
  );
}

buildRegister() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        "Kayıt Ol",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Color(0xff4c505b)),
      ),
      CircleAvatar(
        radius: 30,
        backgroundColor: const Color(0xff4c505b),
        child: IconButton(
          //FIREBASE KISMI
          onPressed: () => {},
          //icon androidde gözükmüyorsa sondaki '_ios' kısmını silin.
          icon: const Icon(Icons.arrow_forward_ios),
          color: Colors.white,
        ),
      ),
    ],
  );
}
