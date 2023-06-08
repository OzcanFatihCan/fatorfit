import 'package:fatorfit/services/auth_service.dart';
import 'package:fatorfit/tools/wrapper.dart';
import 'package:fatorfit/view/actvitypage/training_detail.dart';
import 'package:fatorfit/view/ffhome.dart';
import 'package:fatorfit/view/homepage/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/actvitypage/activity.dart';
import 'view/actvitypage/activity_detail.dart';
import 'view/actvitypage/training.dart';
import 'view/dietpage/diet.dart';
import 'view/homepage/home.dart';
import 'view/loginpage/login.dart';
import 'view/loginpage/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'view/progresspage/progress.dart';
import 'view/progresspage/progress_history.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "ffhome",
        routes: {
          "/": (context) => const Wrapper(),
          "login": (context) => const LoginPage(),
          "register": (context) => const RegisterPage(),
          "home": (context) => const HomePage(),
          "profile": (context) => const ProfilePage(),
          "aktivity": (context) => const AktivityPage(),
          "diet": (context) => const DietPage(),
          "progress": (context) => const ProgressPage(),
          "ffhome": (context) => const FatorFitHome(),
          "detailaktivity": (context) => const ActivityDetailPage(),
          "training": (context) => const TrainingPage(),
          "detailtraining": (context) => const TrainingDetailPage(),
          "progresshistory": (context) => const ProgressHistoryPage(),
        },
      ),
    ),
  );
}
