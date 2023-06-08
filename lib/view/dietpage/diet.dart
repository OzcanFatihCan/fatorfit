import 'package:fatorfit/theme/themecolor.dart';
import 'package:flutter/material.dart';

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  TextEditingController searchController = TextEditingController();
  List<String> allItems = [
    'Su & İçecek',
    'Meyve & Sebze',
    'Temel Gıda',
    'Atıştırmalık',
    'Kahvaltılık',
    'Süt Ürünleri',
    'Fit & Form',
    'Kuruyemiş',
    'Yiyecek',
  ];
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterItems(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredItems = allItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredItems = allItems;
      });
    }
  }

  void handleItemClick(String item) {
    print('Tıklandı: $item');
  }

  Widget buildButtonWithImage(String title) {
    AssetImage? image;

    if (title == 'Su & İçecek') {
      image = const AssetImage('assets/su_icecek.png');
    } else if (title == 'Meyve & Sebze') {
      image = const AssetImage('assets/meyve_sebze.png');
    } else if (title == 'Temel Gıda') {
      image = const AssetImage('assets/temel_gida.png');
    } else if (title == 'Atıştırmalık') {
      image = const AssetImage('assets/atistirmalik.png');
    } else if (title == 'Kahvaltılık') {
      image = const AssetImage('assets/kahvaltilik.png');
    } else if (title == 'Süt Ürünleri') {
      image = const AssetImage('assets/sut_urunleri.png');
    } else if (title == 'Fit & Form') {
      image = const AssetImage('assets/fit_form.png');
    } else if (title == 'Kuruyemiş') {
      image = const AssetImage('assets/kuruyemis.png');
    } else if (title == 'Yiyecek') {
      image = const AssetImage('assets/yiyecek.png');
    }

    return GestureDetector(
      onTap: () {
        handleItemClick(title);
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Theme(
                data: ThemeData(
                  primaryColor: AppColors.appbarColor, // Çerçeve rengi
                  primaryColorDark: AppColors.appbarColor, // Çerçeve rengi
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.appbarColor,
                      ), // Çerçeve rengi
                      borderRadius:
                          BorderRadius.circular(10.0), // Çerçeve köşe yarıçapı
                    ),
                  ),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: filterItems,
                  decoration: const InputDecoration(
                    labelText: 'Arama',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: filteredItems
                      .map((item) => buildButtonWithImage(item))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
