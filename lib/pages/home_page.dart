import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/get_categories/get_categories_cubit.dart';
import 'package:store_app/cubits/get_commerce/get_commerce_cubit.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/pages/add_product_page.dart';
import 'package:store_app/pages/favorites_page.dart';
import 'package:store_app/widgets/custom_all_delete_icon.dart';
import 'package:store_app/widgets/custom_app_bar_fav_icon.dart';
import 'package:store_app/widgets/custom_filter_button.dart';
import 'package:store_app/widgets/custom_search_icon.dart';
import 'package:store_app/widgets/product_list_cubit_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];
  List<ProductModel> favoriteProducts = [];
  List<String> categories = [];
  List<String> selectedCategories = [];
  final controller = TextEditingController();
  bool allProductsDeleted = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetCommerceCubit>(context).fetchAllProducts();
    BlocProvider.of<GetCategoriesCubit>(context).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0.5,
        shadowColor: Colors.grey.shade100,
        automaticallyImplyLeading: true,
        title: const Text('New Trend'),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, FavoritesPage.id);
          },
          icon: const AppBarFavIcon(),
        ),
        actions: [
          BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
            builder: (context, state) {
              Widget filterButton = CustomFilterButton(
                categories: state is GetCategoriesSuccess
                    ? state.categories
                    : categories,
                selectedCategories: categories,
                onFilterApplied: (selectedCategories) {
                  setState(() {
                    categories = selectedCategories;
                  BlocProvider.of<GetCommerceCubit>(context)
                      .applyFilter(selectedCategories);
                  });
                },
                allProductsDeleted: allProductsDeleted,
              );
              return filterButton;
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddProductPage.id);
        },
        backgroundColor: Colors.white,
        elevation: 50,
        tooltip: 'Add new product',
        splashColor: const Color.fromARGB(255, 255, 255, 255),
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.green.shade200,
            strokeAlign: BorderSide.strokeAlignOutside,
            width: 0.5,
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.green,
          size: 26,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 2, left: 2),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(3, 8, 3, 10),
              child: Row(
                children: [
                  CustomSearchIcon(controller: controller),
                  CustomAllDeleteIcon(
                    onDeleteAll: () {
                      BlocProvider.of<GetCommerceCubit>(context)
                          .updateProducts([]);
                      allProductsDeleted = true;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            ProductListCubitBuilder(
              products: products,
              favoriteProducts: favoriteProducts,
              onProductDeleted: (String id) {
                BlocProvider.of<GetCommerceCubit>(context)
                    .deleteProduct(int.parse(id));
              },
            ),
          ],
        ),
      ),
    );
  }
}
