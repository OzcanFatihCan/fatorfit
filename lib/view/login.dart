import 'package:fatorfit/theme/themecolor.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            //assets klasorunden arka plana aktarma alanı
            image: AssetImage('assets/login.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            buildLogo(),
            buildScrollView(context),
          ],
        ),
      ),
    );
  }
}

//scrollview
buildScrollView(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.5,
        left: 38,
        right: 38,
      ),
      child: Column(
        children: [
          buildAccountId(),
          const SizedBox(height: 30),
          buildAccountPassword(),
          const SizedBox(height: 30),
          buildSignIntoFF(),
          const SizedBox(height: 30),
          buildSignUp(context),
        ],
      ),
    ),
  );
}

//logo
buildLogo() {
  return Container(
    padding: const EdgeInsets.only(left: 130, top: 40),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(200),
      child: Image.asset(
        "assets/Logo.png",
        width: 150,
        height: 150,
      ),
    ),
  );
}

//kullanıcı adı veya email giriş
buildAccountId() {
  return TextField(
    decoration: InputDecoration(
      fillColor: AppColors.textFieldColor,
      filled: true,
      hintText: 'Kullanıcı Adı veya E-Mail',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );
}

//parola giriş
buildAccountPassword() {
  return TextField(
    obscureText: true,
    decoration: InputDecoration(
      fillColor: AppColors.textFieldColor,
      filled: true,
      hintText: 'Şifre',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );
}

//giriş yap
buildSignIntoFF() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      const Text(
        "Giriş Yap",
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

//kayıt ol & şifremi unuttum
buildSignUp(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      TextButton(
        onPressed: () => {},
        child: const Text(
          "Şifremi Unuttum",
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 15,
              color: Color.fromRGBO(89, 191, 231, 1)),
        ),
      ),
      TextButton(
        onPressed: () => {
          Navigator.pushNamed(context, 'register'),
        },
        child: const Text(
          "Hesap Oluştur",
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 15,
            color: Color.fromRGBO(89, 191, 231, 1),
          ),
        ),
      ),
    ],
  );
}
