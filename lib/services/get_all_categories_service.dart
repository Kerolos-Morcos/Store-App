
import 'package:store_app/constants.dart';
import 'package:store_app/helper/api_helper.dart';

class GetAllCategoriesService
{
  Future<List<dynamic>> getAllCategories() async
  {
    List<dynamic> data = await ApiHelper().getRequest(url: '$kBaseUrl/products/categories');
    return data;
  }
}