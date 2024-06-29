import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/helper/show_snack_bar.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/pages/add_product_page.dart';
import 'package:store_app/pages/favorites_page.dart';
import 'package:store_app/services/get_all_categories_service.dart';
import 'package:store_app/services/get_all_products_service.dart';
import 'package:store_app/widgets/custom_filter_button.dart';
import 'package:store_app/widgets/custom_product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_typing_uninitialized_variables
  var future;
  List<ProductModel> products = [],
      displayedProducts = [],
      favoriteProducts = [];
  List<String> categories = [], selectedCategories = [];
  final controller = TextEditingController();
  String query = '';
  bool isLoading = true, allProductsDeleted = false;
  Map<int, bool> favoriteStatus = {};
  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      categories =
          (await GetAllCategoriesService().getAllCategories()).cast<String>();
      setState(() {});
    } catch (e) {
      log('Error fetching categories: $e');
    }
  }

  void fetchProducts() async {
    try {
      products = await GetAllProductsService().getAllProducts();
      setState(() {
        displayedProducts = products;
        initializeFavoriteStatus();
      });
      isLoading = false;
    } catch (e) {
      log('Error fetching products: $e');
    }
  }

  void initializeFavoriteStatus() {
    for (var product in products) {
      favoriteStatus[product.id] = false;
    }
  }

  void searchProduct() {
    final suggestions = query.isEmpty
        ? products
        : products.where((product) {
            final productName = product.title.toLowerCase();
            final input = query.toLowerCase();
            return productName.contains(input);
          }).toList();
    setState(() {
      displayedProducts = suggestions;
    });
  }

  void updateDisplayedProducts(List<String> selectedCategories) {
    this.selectedCategories = selectedCategories;
    if (selectedCategories.isEmpty) {
      setState(() {
        displayedProducts = products;
      });
    } else {
      final filteredProducts = products.where((product) {
        return selectedCategories.contains(product.category);
      }).toList();
      setState(() {
        displayedProducts = filteredProducts;
      });
    }
  }

  void toggleFavoriteStatus(int id) {
    setState(() {
      favoriteStatus[id] = !favoriteStatus[id]!;
      if (favoriteStatus[id]!) {
        // Add product only if it's not already in the list
        if (!favoriteProducts.any((product) => product.id == id)) {
          favoriteProducts
              .add(products.firstWhere((product) => product.id == id));
        }
      } else {
        // Remove product from favorites
        favoriteProducts.removeWhere((product) => product.id == id);
      }
    });
  }

  void updateFavorites(Map<int, bool> updatedFavorites) {
    setState(() {
      favoriteStatus = updatedFavorites;
      // Update the favoriteProducts list based on the updated favorites status
      favoriteProducts = products
          .where((product) => favoriteStatus[product.id] == true)
          .toList();
    });
  }

  Future<bool> showAlertDialog(BuildContext context, String message) async {
    Widget cancelButton = ElevatedButton(
      child: const Text(
        "No",
        style: TextStyle(color: Colors.green),
      ),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = ElevatedButton(
      child: const Text(
        "Yes",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        products.clear();
        displayedProducts.clear();
        allProductsDeleted = true;
        showSnackBar(context, 'All Products Deleted Successfully !',
            backgroundColor: Colors.green);
        setState(() {});
        Navigator.of(context).pop(true);
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Deleting All Products"),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    ); // show the dialog
    final result = await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return result ?? false;
  }

  Icon getIcon() {
    if (favoriteProducts.isNotEmpty && allProductsDeleted == false) {
      return const Icon(
        FontAwesomeIcons.solidHeart,
        size: 30,
        color: Colors.red,
      );
    } else {
      return const Icon(
        FontAwesomeIcons.heart,
        size: 30,
        color: Colors.red,
      );
    }
  }

  void onProductDeleted(String id) {
    setState(() {
      products.removeWhere((product) => product.id.toString() == id);
      displayedProducts.removeWhere((product) => product.id.toString() == id);
      favoriteProducts.removeWhere((product) => product.id.toString() == id);
      if (displayedProducts.isEmpty) {
        allProductsDeleted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritesPage(
                  products: favoriteProducts,
                  onUpdateFavorites: updateFavorites,
                  favoriteStatus: favoriteStatus,
                  allProductsDeleted: allProductsDeleted,
                ),
              ),
            );
          },
          icon: getIcon(),
        ),
        actions: [
          CustomFilterButton(
            categories: categories,
            selectedCategories: selectedCategories,
            onFilterApplied: updateDisplayedProducts,
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
        padding: const EdgeInsets.only(right: 5.0, left: 5, top: 2, bottom: 2),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 83,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(3, 8, 3, 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: TextField(
                        controller: controller,
                        onChanged: (value) {
                          setState(() {
                            query = value;
                          });
                          searchProduct();
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Product Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          showAlertDialog(
                            context,
                            'Are you sure you want to delete all products?',
                          );
                        },
                        child: const Icon(
                          Icons.delete,
                          size: 33,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : displayedProducts.isEmpty && allProductsDeleted
                        ? const Center(
                            child: Text(
                              'No products available !',
                              style: TextStyle(fontSize: 26),
                            ),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.only(top: 50, bottom: 20),
                            physics: const BouncingScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.6,
                              mainAxisSpacing: 65,
                            ),
                            itemCount: displayedProducts.length,
                            itemBuilder: (context, index) {
                              final product = displayedProducts[index];
                              return CustomProductCard(
                                isEnabled: true,
                                id: product.id,
                                onDelete: onProductDeleted,
                                productModel: product,
                                isFavorite: favoriteStatus[product.id] ?? false,
                                onToggleFavorite: toggleFavoriteStatus,
                              );
                            },
                          ),
              ),
              const SizedBox(
                height: 45,
              )
            ],
          ),
        ),
      ),
    );
  }
}
