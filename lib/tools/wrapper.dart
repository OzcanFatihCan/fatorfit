import 'package:fatorfit/models/user_model.dart';
import 'package:fatorfit/services/auth_service.dart';
import 'package:fatorfit/view/homepage/home.dart';
import 'package:fatorfit/view/loginpage/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final mystream = authService.user;
    mystream?.listen(
      (user) {
        if (user != null) {
          final uid = user.userId;
          final email = user.userMail;
          print("mail: ${email}, id: ${uid}");
        }
      },
    );
    return StreamBuilder<AppUser?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<AppUser?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final AppUser? user = snapshot.data;
          if (user == null) {
            // Kullanıcı giriş yapmadı, LoginPage açılacak
            return const LoginPage();
          } else {
            // Giriş başarılı HomePage, açılacak.
            return const HomePage();
          }
        } else if (snapshot.hasError) {
          // Giriş yaparken bir hata oluştu
          Future.delayed(const Duration(milliseconds: 50), () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Bilgilerinizi kontrol ediniz.'),
              ),
            );
          });
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
