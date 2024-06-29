import 'package:flutter/material.dart';
import 'package:store_app/pages/add_product_page.dart';
import 'package:store_app/pages/favorites_page.dart';
import 'package:store_app/pages/home_page.dart';
import 'package:store_app/pages/update_product_page.dart';

void main() {
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.id: (context) => const HomePage(),
        UpdateProductPage.id: (context) => const UpdateProductPage(),
        AddProductPage.id: (context) => const AddProductPage(),
        FavoritesPage.id: (context) => const FavoritesPage(),
      },
      initialRoute: HomePage.id,
    );
  }
}
