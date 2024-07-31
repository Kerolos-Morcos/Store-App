import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store_app/helper/show_snack_bar.dart';
import 'package:store_app/services/add_product_service.dart';
import 'package:store_app/widgets/custom_button.dart';
import 'package:store_app/widgets/custom_text_field.dart';
import 'package:store_app/widgets/custom_upload_pic.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});
  static const id = 'AddProductPage';

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String? price, productName, description, category, image;
  bool isLoading = false;
  int? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add New Product'),
        elevation: 0.5,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        shadowColor: Colors.grey.shade100,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 20,
          ),
          const CustomUploadPic(
            productImage:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvwT10DWaK6cYFH6SZUxx-18rvmT-lN3XUpg&s',
            radius: 70,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Title',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          CustomTextField(
            hintText: 'Add the product name',
            onChanged: (value) {
              productName = value;
            },
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Price',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          CustomTextField(
              hintText: 'Add product\'s  price in \$',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                price = value;
              }),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          CustomTextField(
              hintText: 'Add a short description',
              onChanged: (value) {
                description = value;
              }),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Category',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          CustomTextField(
              hintText: 'Add the products\'s category',
              onChanged: (value) {
                category = value;
              }),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            buttonText: 'Add Product',
            onTap: () async {
              isLoading = true;
              setState(() {});
              try {
                await addProduct();
                log('success');
                showSnackBar(
                  // ignore: use_build_context_synchronously
                  context,
                  'Product added Successfully !',
                  backgroundColor: Colors.green,
                );
                Future.delayed(const Duration(seconds: 4));
              } catch (e) {
                log(e.toString());
              }
              isLoading = false;
              setState(() {});
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            buttonTextColor: Colors.white,
            buttonBackgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }

  Future<void> addProduct() async {
    await AddProductService().addProduct(
      title: productName == null ? 'product title' : productName!,
      price: price == null ? 'product price \$' : price!,
      description: description == null ? 'product description' : description!,
      image: image == null ? 'product image' : image!,
      category: category == null ? 'product category' : category!,
    );
  }
}
