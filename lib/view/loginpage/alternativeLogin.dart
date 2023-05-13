import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';

import '../../services/auth_service.dart';

class AlternativeSignUp extends StatelessWidget {
  const AlternativeSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
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
        Column(children: [
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text(
              "Alternatif Giriş Yöntemi",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(1000, 58, 67, 76),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SignInButton(
            buttonType: ButtonType.google,
            btnText: "Google ile giriş yap",
            buttonSize: ButtonSize.large,
            onPressed: () async {
              await authService.signInWithGoogle();
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ])
      ],
    );
  }
}
