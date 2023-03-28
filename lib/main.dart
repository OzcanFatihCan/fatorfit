import 'package:flutter/material.dart';

import 'view/home.dart';
import 'view/login.dart';
import 'view/register.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "login",
    routes: {
      "login": (context) => const LoginPage(),
      "register": (context) => const RegisterPage(),
      "home": (context) => const HomePage(),
    },
  ));
}
