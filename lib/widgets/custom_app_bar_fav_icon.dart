import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/cubits/get_commerce/get_commerce_cubit.dart';

class AppBarFavIcon extends StatelessWidget {
  const AppBarFavIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCommerceCubit, GetCommerceState>(
      builder: (context, state) {
        if (state is GetCommerceSuccess && state.products.isNotEmpty) {
          bool hasFavoriteProducts = state.favoriteStatus.values.any((favorite) => favorite);
          return hasFavoriteProducts
              ? const Icon(
                  FontAwesomeIcons.solidHeart,
                  size: 30,
                  color: Colors.red,
                )
              : const Icon(
                  FontAwesomeIcons.heart,
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
      },
    );
  }
}
