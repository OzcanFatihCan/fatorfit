import 'package:fatorfit/services/auth_service.dart';
import 'package:fatorfit/tools/wrapper.dart';
import 'package:fatorfit/view/deneme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/home.dart';
import 'view/login.dart';
import 'view/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      Provider<AuthService>(
        create: (_) => AuthService(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const Wrapper(),
        "login": (context) => const LoginPage(),
        "register": (context) => const RegisterPage(),
        "home": (context) => const HomePage(),
        "deneme": (context) => const TextFieldExampleState(),
      },
    ),
  ));
}
