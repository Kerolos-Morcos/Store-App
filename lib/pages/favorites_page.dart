import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/widgets/custom_product_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage(
      {super.key,
      this.favoriteStatus,
      this.products,
      this.onUpdateFavorites,
      this.allProductsDeleted});
  static String id = 'FavoritePage';
  final Map<int, bool>? favoriteStatus;
  final List<ProductModel>? products;
  final Function(Map<int, bool>)? onUpdateFavorites;
  final bool? allProductsDeleted;

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late List<ProductModel> favoriteProducts;
  late Map<int, bool> favoriteStatus;

  @override
  void initState() {
    super.initState();
    favoriteStatus = widget.favoriteStatus!;
    updateFavoriteProducts();
  }

  void updateFavoriteProducts() {
    favoriteProducts = widget.products!
        .where((product) => favoriteStatus[product.id] ?? false)
        .toList();
  }

  void toggleFavorite(int id) {
    setState(() {
      favoriteStatus[id] = !favoriteStatus[id]!;
      updateFavoriteProducts();
    });
    widget.onUpdateFavorites!(favoriteStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        shadowColor: Colors.grey.shade100,
        automaticallyImplyLeading: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Favorites '),
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: favoriteProducts.isEmpty || widget.allProductsDeleted == true
          ? const Center(
              child: Text(
                'No favorites yet!',
                style: TextStyle(fontSize: 26),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              physics: const BouncingScrollPhysics(),
              clipBehavior: Clip.hardEdge,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.6,
                mainAxisSpacing: 65,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return CustomProductCard(
                  isEnabled: false,
                  id: product.id,
                  onDelete: (id) {},
                  productModel: product,
                  isFavorite: true,
                  onToggleFavorite: toggleFavorite,
                );
              },
            ),
    );
  }
}
