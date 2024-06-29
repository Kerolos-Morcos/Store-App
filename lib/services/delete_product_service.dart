import 'dart:developer';

import 'package:store_app/helper/api_helper.dart';

class DeleteProductService {
  Future<bool> deleteProduct(String id) async {
    try {
      await Api().delete(url: 'https://fakestoreapi.com/products/$id');
      log('Product deleted successfully');
      return true;
    } catch (e) {
      log('Failed to delete product: $e');
      return false;
    }
  }
}