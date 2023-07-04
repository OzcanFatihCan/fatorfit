//import '../designs/homedesign.dart';
//import 'package:fluid_action_card/FluidActionCard/fluid_action_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fatorfit/designs/frostedglass.dart';
import 'package:fatorfit/theme/themecolor.dart';
import 'package:fatorfit/view/homepage/miniprofile.dart';
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
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      "",
      "",
      "",
    ];

    final List<Widget> images = [
      const FrostedGlassBox(
        theWidth: 200.0,
        theHeight: 200.0,
        theChild: Text(
          'AKTIVITE',
          style: TextStyle(
              color: AppColors.textHome,
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      const FrostedGlassBox(
        theWidth: 200.0,
        theHeight: 200.0,
        theChild: Text(
          'DIYET',
          style: TextStyle(
              color: AppColors.textHome,
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      const FrostedGlassBox(
        theWidth: 200.0,
        theHeight: 200.0,
        theChild: Text(
          'GELISIM',
          style: TextStyle(
              color: AppColors.textHome,
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    ];
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: VerticalCardPager(
                  titles: titles, // required
                  images: images, // required
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ), // optional
                  onPageChanged: (page) {
                    // optional
                  },
                  onSelectedItem: (index) async {
                    if (index == 0) {
                      await Navigator.pushNamed(context, "aktivity");
                    } else if (index == 1) {
                      await Navigator.pushNamed(context, "diet");
                    } else {
                      await Navigator.pushNamed(context, "progress");
                    }
                  },
                  initialPage: 1, // optional
                  align: ALIGN.CENTER, // optional
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  _buildBottomBar(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    _showModalBottomSheet(context) async {
      await Future.delayed(const Duration(milliseconds: 500));
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.8,
          maxChildSize: 0.95,
          minChildSize: 0.32,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: const MiniProfilePage(),
            );
          },
        ),
      );
    }

    return CurvedNavigationBar(
      key: bottomNavigationKey,
      index: 0,
      height: 60.0,
      items: const <Widget>[
        Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.person_2,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.exit_to_app_rounded,
          size: 30,
          color: Colors.white,
        ),
      ],
      color: AppColors.bottomNavBarColor,
      buttonBackgroundColor: AppColors.bottomNavBarColor,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      onTap: (index) async {
        _page = index;
        if (_page == 1) {
          await _showModalBottomSheet(context);
        } else if (_page == 2) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              title: const Text('Çıkış'),
              content: const Text('Çıkış yapmak istiyor musunuz?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Hayır'),
                  child: const Text('Hayır'),
                ),
                TextButton(
                  onPressed: () async {
                    await Future.delayed(const Duration(milliseconds: 400));
                    Navigator.pop(context, 'Evet');
                    await authService.signOut();
                    await authService.signOutWithGoogle();
                  },
                  child: const Text('Evet'),
                ),
              ],
            ),
          );
        }
      },
      letIndexChange: (index) => true,
    );
  }
}
