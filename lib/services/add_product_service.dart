import 'package:store_app/constants.dart';
import 'package:store_app/helper/api_helper.dart';
import 'package:store_app/models/product_model.dart';

class AddProductService {
  Future<ProductModel> addProduct(
      {required String title,
      required String price,
      required String description,
      required String image,
      required String category}) async {
    List<dynamic> data =
        await ApiHelper().postRequest(url: '$kBaseUrl/products', body: {
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
    });
    return ProductModel.fromJson(data);
  }
}
