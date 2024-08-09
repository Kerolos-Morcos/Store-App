import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/get_commerce/get_commerce_cubit.dart';
import 'package:store_app/widgets/custom_product_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  static String id = 'FavoritePage';

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
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
      body: BlocBuilder<GetCommerceCubit, GetCommerceState>(
        builder: (context, state) {
          if (state is GetCommerceSuccess) {
            final favoriteProducts = state.products
                .where((product) => state.favoriteStatus[product.id] ?? false)
                .toList();

            if (favoriteProducts.isEmpty) {
              return const Center(
                child: Text(
                  'No favorites yet!',
                  style: TextStyle(fontSize: 26),
                ),
              );
            } else {
              return GridView.builder(
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
                    onToggleFavorite: (productId) {
                      BlocProvider.of<GetCommerceCubit>(context)
                          .toggleFavoriteStatus(productId);
                    },
                  );
                },
              );
            }
          } else {
            return const Center(
              child: Text(
                'Something went wrong!',
                style: TextStyle(fontSize: 26),
              ),
            );
          }
        },
      ),
    );
  }
}
