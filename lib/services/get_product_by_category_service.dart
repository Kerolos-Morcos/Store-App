
import 'package:store_app/constants.dart';
import 'package:store_app/helper/api_helper.dart';
import 'package:store_app/models/product_model.dart';

class GetProductByCategoryService
{
  Future<List<ProductModel>> getProductByCategoryService({required String categoryName}) async
  {
    List<dynamic> data = await ApiHelper().getRequest(url: '$kBaseUrl/products/category/$categoryName');
    List<ProductModel> productsList = [];
    for (var i = 0; i < data.length; i++) {
      productsList.add(ProductModel.fromJson(data[i]));
    }
    return productsList;
  }
}