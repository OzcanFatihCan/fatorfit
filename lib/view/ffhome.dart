import 'package:flutter/material.dart';

class FatorFitHome extends StatefulWidget {
  const FatorFitHome({super.key});

  @override
  State<FatorFitHome> createState() => _FatorFitHomeState();
}

class _FatorFitHomeState extends State<FatorFitHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Center(
          child: Text(
            "FAT OR FIT",
            style: TextStyle(
              color: Colors.white,
              fontSize: 41.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: _buildFFHome(context),
    );
  }
}

_buildFFHome(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.amber, Colors.amber],
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.asset(
              'assets/Logo.png',
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(height: 10.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(200.0),
            child: Image.asset(
              'assets/fitfat.gif',
              fit: BoxFit.cover,
              width: 320.0,
              height: 320.0,
            ),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () async {
              await Navigator.pushNamed(context, "/");
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 44.0,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
            child: const Text(
              "BAŞLA",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            "Hala kayıt olmadın mı?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15.0),
          ElevatedButton(
            onPressed: () async {
              await Navigator.pushNamed(context, "register");
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 30.0,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
            child: const Text(
              "KAYIT OL",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
