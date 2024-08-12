import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/get_commerce/get_commerce_cubit.dart';

void searchProduct(BuildContext context, String value) {
  final cubit = BlocProvider.of<GetCommerceCubit>(context);
  final products = cubit.displayedProducts; // Search within the filtered list if any filters are active

  if (value.isEmpty) {
    // If the search query is empty, restore the currently filtered products
    cubit.updateProducts(products);
  } else {
    final suggestions = products.where((product) {
      final productName = product.title.toLowerCase();
      final input = value.toLowerCase();
      return productName.contains(input);
    }).toList();
    
    // Update the displayed list based on search results
    cubit.updateProducts(suggestions);
  }
}
