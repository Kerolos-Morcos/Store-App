import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/helper/show_snack_bar.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/update_product_service.dart';
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
    return ModalProgressHUD(
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
                productName ?? product.title.substring(0, 11),
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
                productName ?? product.title.substring(0, 11),
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
              onTap: () async {
                isLoading = true;
                setState(() {});
                try {
                  await updateProduct(product);
                  log('success');
                  showSnackBar(
                    // ignore: use_build_context_synchronously
                    context,
                    'Product Updated Successfully !',
                    backgroundColor: Colors.green,
                  );
                  Future.delayed(const Duration(seconds: 4));  
                } catch (e) {
                  log(e.toString());
                }
                isLoading = false;
                setState(() {});
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, product);
              },
              buttonTextColor: Colors.white,
              buttonBackgroundColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateProduct(ProductModel product) async {
    await UpdateProductService().updateProduct(
      id: product.id.toString(),
      title: productName == null ? product.title : productName!,
      price: price == null ? product.price.toString() : price!,
      description: description == null ? product.description : description!,
      image: image == null ? product.image : image!,
      category: product.category,
    );
  }
}
