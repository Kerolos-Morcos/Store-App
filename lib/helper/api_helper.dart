import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  Future<dynamic> getRequest({required String url}) async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Failed to load data, ERROR_CODE: ${response.statusCode}',
      );
    }
  }
}