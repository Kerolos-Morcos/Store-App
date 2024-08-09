import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/get_commerce/get_commerce_cubit.dart';

searchProduct(BuildContext context, String value) {
  String query = '';
  query = value;
  final cubit = BlocProvider.of<GetCommerceCubit>(context);
  final cubitProducts = BlocProvider.of<GetCommerceCubit>(context).products;
  final suggestions = query.isEmpty
      ? cubitProducts
      : cubitProducts.where((product) {
          final productName = product.title.toLowerCase();
          final input = query.toLowerCase();
          return productName.contains(input);
        }).toList();
  cubit.updateProducts(suggestions);
}
