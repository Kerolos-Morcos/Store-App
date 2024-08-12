import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/get_commerce/get_commerce_cubit.dart';
import 'package:store_app/helper/show_snack_bar.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/pages/update_product_page.dart';
import 'package:store_app/services/delete_product_service.dart';

class CustomProductCard extends StatefulWidget {
  const CustomProductCard({
    super.key,
    required this.productModel,
    required this.onDelete,
    required this.id,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.isEnabled,
  });
  final ProductModel productModel;
  final Function(String) onDelete;
  final int id;
  final bool isFavorite;
  final bool isEnabled;
  final Function(int) onToggleFavorite;
  @override
  State<CustomProductCard> createState() => _CustomProductCardState();
}

class _CustomProductCardState extends State<CustomProductCard> {
  List<ProductModel> products = [];
  IconData icon = Icons.favorite_outline;
  IconData afterPressIcon = Icons.favorite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 40,
                color: Colors.grey.shade100,
                offset: const Offset(5, 5),
              )
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            elevation: 6.0,
            shadowColor: Colors.grey.shade100,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PopupMenuButton(
                    enabled: widget.isEnabled,
                    color: Colors.white,
                    icon: const Icon(
                      Icons.more_horiz_outlined,
                      size: 25,
                      color: Colors.grey,
                    ),
                    padding: const EdgeInsets.fromLTRB(-10, 0, 40, 30),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              UpdateProductPage.id,
                              arguments: widget.productModel,
                            ).then((updatedProduct) {
                              if (updatedProduct != null) {
                                BlocProvider.of<GetCommerceCubit>(context)
                                    .refreshProduct(
                                        updatedProduct as ProductModel);
                              }
                            });
                          },
                          height: 25,
                          value: 'edit',
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () async {
                            try {
                              bool success = await DeleteProductService()
                                  .deleteProduct(
                                      widget.productModel.id.toString());
                              if (success) {
                                widget.onDelete(
                                    widget.productModel.id.toString());
                                showSnackBar(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  'Product Deleted Successfully !',
                                  backgroundColor: Colors.green,
                                );
                              }
                            } catch (e) {
                              showSnackBar(
                                // ignore: use_build_context_synchronously
                                context,
                                'Error Deleting Product !, Error Message ${e.toString()}',
                                backgroundColor: Colors.red,
                              );
                            }
                          },
                          height: 45,
                          value: 'delete',
                          child: const Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.red,
                          ),
                        ),
                      ];
                    },
                  ),
                  Text(
                    widget.productModel.title.length >= 12
                        ? widget.productModel.title.substring(0, 11)
                        : widget.productModel.title,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.productModel.price.toString()}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          try {
                            widget.onToggleFavorite(widget.id);
                            if (!widget.isFavorite) {
                              showSnackBar(context,
                                  'Product added to Favorites Successfully !',
                                  backgroundColor: Colors.green);
                            } else {
                              showSnackBar(
                                  context, 'Product removed from Favorites !',
                                  backgroundColor: Colors.blueGrey);
                            }
                          } catch (e) {
                            log('failed $e');
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Icon(
                            widget.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 26,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          right: 7,
          child: Image.network(
            widget.productModel.image.isNotEmpty
                ? widget.productModel.image
                : 'https://media.istockphoto.com/id/1353254084/vector/1401-i012-025-p-m001-c20-woman-accessories.jpg?s=612x612&w=0&k=20&c=Fqp5ckKD3HMmcybXsRlsNqD55rQrF1xu0uPdia2MAPQ=',
            height: 80,
            width: 80,
          ),
        ),
      ],
    );
  }
}
