//import '../designs/homedesign.dart';
//import 'package:fluid_action_card/FluidActionCard/fluid_action_card.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:fatorfit/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final List<String> titles = [
      "",
      "",
      "",
    ];

    final List<Widget> images = [
      Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
              //assets klasorunden arka plana aktarma alanı
              image: AssetImage('assets/aktivite.png'),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
              //assets klasorunden arka plana aktarma alanı
              image: AssetImage('assets/diyet.png'),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
              //assets klasorunden arka plana aktarma alanı
              image: AssetImage('assets/gelisim.png'),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fat or Fit"),
        centerTitle: true,
        toolbarHeight: 40,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app_rounded),
          onPressed: () async {
            await authService.signOut();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 50),
                content: Text('Çıkış Yapılıyor'),
              ),
            );
          },
        ),
        elevation: 0.00,
        backgroundColor: Color.fromARGB(255, 22, 175, 196),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: VerticalCardPager(
                    titles: titles, // required
                    images: images, // required
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold), // optional
                    onPageChanged: (page) {
                      // optional
                    },
                    onSelectedItem: (index) {
                      // optional
                    },
                    initialPage: 0, // optional
                    align: ALIGN.CENTER // optional
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
