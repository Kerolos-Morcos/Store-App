import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/get_commerce/get_commerce_cubit.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/widgets/custom_product_card.dart';

class ProductListCubitBuilder extends StatelessWidget {
  const ProductListCubitBuilder({
    super.key,
    required this.products,
    required this.favoriteProducts,
    required this.onProductDeleted,
  });
  final List<ProductModel> products;
  final List<ProductModel> favoriteProducts;
  final Function(String) onProductDeleted;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<GetCommerceCubit, GetCommerceState>(
        builder: (context, state) {
          if (state is GetCommerceLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetCommerceSuccess) {
            if (state.products.isEmpty) {
              return const Center(
                child: Text(
                  'No Products Available !',
                  style: TextStyle(fontSize: 26),
                ),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.only(top: 40, bottom: 60),
              physics: const BouncingScrollPhysics(),
              clipBehavior: Clip.hardEdge,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.6,
                mainAxisSpacing: 65,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                bool isFavorite = state.favoriteStatus[product.id] ?? false;
                return CustomProductCard(
                  isEnabled: true,
                  id: product.id,
                  onDelete: onProductDeleted,
                  productModel: product,
                  isFavorite: isFavorite,
                  onToggleFavorite: (productId) {
                    BlocProvider.of<GetCommerceCubit>(context)
                        .toggleFavoriteStatus(productId);
                  },
                );
              },
            );
          } else if (state is GetCommerceFailure) {
            return Center(
              child: Text('Error: ${state.errorMessage}'),
            );
          } else {
            return const Center(
              child: Text(
                'No Products Available !',
                style: TextStyle(fontSize: 26),
              ),
            );
          }
        },
      ),
    );
  }
}
