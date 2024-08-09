import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/get_categories/get_categories_cubit.dart';
import 'package:store_app/cubits/get_commerce/get_commerce_cubit.dart';
import 'package:store_app/pages/add_product_page.dart';
import 'package:store_app/pages/favorites_page.dart';
import 'package:store_app/pages/home_page.dart';
import 'package:store_app/pages/update_product_page.dart';
import 'package:store_app/services/get_all_categories_service.dart';
import 'package:store_app/services/get_all_products_service.dart';

void main() {
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetCommerceCubit(
            GetAllProductsService(),
          ),
        ),
        BlocProvider(
          create: (context) => GetCategoriesCubit(
            GetAllCategoriesService(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          HomePage.id: (context) => const HomePage(),
          UpdateProductPage.id: (context) => const UpdateProductPage(),
          AddProductPage.id: (context) => const AddProductPage(),
          FavoritesPage.id: (context) => const FavoritesPage(),
        },
        initialRoute: HomePage.id,
      ),
    );
  }
}
