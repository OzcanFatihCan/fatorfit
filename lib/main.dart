import 'package:fatorfit/services/auth_service.dart';
import 'package:fatorfit/tools/wrapper.dart';
import 'package:fatorfit/view/homepage/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/actvitypage/activity.dart';
import 'view/dietpage/diet.dart';
import 'view/homepage/home.dart';
import 'view/loginpage/login.dart';
import 'view/loginpage/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'view/progresspage/progress.dart';

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
        "profile": (context) => const ProfilePage(),
        "aktivite": (context) => const AktivitePage(),
        "diyet": (context) => const DiyetPage(),
        "gelisim": (context) => const GelisimPage(),
      },
    ),
  ));
}
