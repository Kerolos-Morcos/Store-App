import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/cubits/edit_commerce/edit_commerce_cubit.dart';
import 'package:store_app/helper/show_snack_bar.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/widgets/custom_button.dart';
import 'package:store_app/widgets/custom_text_field.dart';
import 'package:store_app/widgets/custom_upload_pic.dart';

class UpdateProductPage extends StatefulWidget {
  const UpdateProductPage({super.key});
  static const id = 'UpdateProductPage';

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  String? price, productName, description, category, image;
  bool isLoading = false;
  int? id;
  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return BlocListener<EditCommerceCubit, EditCommerceState>(
      listener: (context, state) {
        if (state is EditCommerceLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is EditCommerceSuccess) {
          showSnackBar(context, 'Product Updated Successfully !',
              backgroundColor: Colors.green);
          Navigator.pop(context, state.product);
        } else if (state is EditCommerceFailure) {
          showSnackBar(context, state.error, backgroundColor: Colors.red);
        }
        setState(() {
          isLoading = false;
        });
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.5,
            surfaceTintColor: Colors.white,
            scrolledUnderElevation: 0,
            shadowColor: Colors.grey.shade100,
            automaticallyImplyLeading: true,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Row(
              children: [
                const Text('Update Product '),
                Text(
                  product.title.length >= 12
                      ? '${product.title.substring(0, 11)}..'
                      : product.title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 15,
              ),
              Align(
                child: Text(
                  productName ?? product.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomUploadPic(
                productImage: product.image,
                radius: 65,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Title',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              CustomTextField(
                onChanged: (data) {
                  setState(() {
                    productName = data;
                  });
                },
                hintText: productName ?? product.title,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Price',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              CustomTextField(
                keyboardType: TextInputType.number,
                onChanged: (data) {
                  setState(() {
                    price = data;
                  });
                },
                hintText: price ?? '\$${product.price}',
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              CustomTextField(
                onChanged: (data) {
                  setState(() {
                    description = data;
                  });
                },
                hintText: description ?? product.description,
              ),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                buttonText: 'Update Product',
                onTap: () {
                  context.read<EditCommerceCubit>().updateProduct(
                        id: product.id.toString(),
                        title: productName ?? product.title,
                        price: price ?? product.price.toString(),
                        description: description ?? product.description,
                        image: image ?? product.image,
                        category: product.category,
                      );
                },
                buttonTextColor: Colors.white,
                buttonBackgroundColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
