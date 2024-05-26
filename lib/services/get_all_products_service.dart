
import 'package:store_app/constants.dart';
import 'package:store_app/helper/api_helper.dart';
import 'package:store_app/models/product_model.dart';

class GetAllProductsService {

  Future<List<ProductModel>> getAllProducts() async {
    List<dynamic> data = await ApiHelper().getRequest(url: '$kBaseUrl/products');
    List<ProductModel> productsList = [];
    for (int i = 0; i < data.length; i++) {
      productsList.add(ProductModel.fromJson(data[i]));
    }
    return productsList;
  }
}