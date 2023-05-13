import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../../theme/themecolor.dart';

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.40,
              left: 38,
              right: 38),
          children: [
            _buildRegisterText(),
            const SizedBox(height: 5),
            _buildRegisterAccountId(_emailController),
            const SizedBox(height: 15),
            _buildRegisterPassword(_passwordController),
            const SizedBox(height: 15),
            _buildRegister(context, _emailController, _passwordController),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _buildRegisterGender() {
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

_buildRegisterText() {
  return const Text(
    "Hesap Oluştur",
    style: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
  );
}

_buildRegisterAccountId(emailController) {
  return TextField(
    controller: emailController,
    decoration: InputDecoration(
        fillColor: AppColors.textFieldColor,
        filled: true,
        hintText: 'E-Mail',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        )),
  );
}

_buildRegisterPassword(passwordController) {
  return TextField(
    controller: passwordController,
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

_buildRegister(
  BuildContext context,
  emailController,
  passwordController,
) {
  final authService = Provider.of<AuthService>(context);
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
          onPressed: () async {
            await authService.createUserWithEmailAndPassword(
              emailController.text,
              passwordController.text,
            );
            Navigator.pop(context);
          },
          //icon androidde gözükmüyorsa sondaki '_ios' kısmını silin.
          icon: const Icon(Icons.arrow_forward_ios),
          color: Colors.white,
        ),
      ),
    ],
  );
}
