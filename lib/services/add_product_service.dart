import 'dart:developer';

import 'package:store_app/helper/api_helper.dart';
import 'package:store_app/models/product_model.dart';

class AddProductService {
  Future<ProductModel> addProduct(
      {required String title,
      required String price,
      required String description,
      required String image,
      required String category}) async {
    try {
      Map<String, dynamic> data =
          await Api().post(url: 'https://fakestoreapi.com/products', body: {
        'title': title,
        'price': price,
        'description': description,
        'image': image,
        'category': category,
      });
      log('Response: $data');
      return ProductModel.fromJson(data);
    } catch (e) {
      log('API Error: $e');
      rethrow;
    }
  }
}
