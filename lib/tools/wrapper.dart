import 'package:fatorfit/models/user_model.dart';
import 'package:fatorfit/services/auth_service.dart';
import 'package:fatorfit/view/home.dart';
import 'package:fatorfit/view/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<AppUser?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<AppUser?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final AppUser? user = snapshot.data;
          return user == null ? const LoginPage() : const HomePage();
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
