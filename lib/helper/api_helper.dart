import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  // Get Request
  Future<dynamic> getRequest({required String url, String? token}) async {
    Map<String, String> headers = {};
    if(token != null){
      headers.addAll({'Authorization' : 'Bearer $token'});
    }
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Failed to load data, ERROR_CODE: ${response.statusCode}',
      );
    }
  }

  // Post Request
  Future<dynamic> postRequest({required String url, required dynamic body, String? token}) async {
    Map<String, String> headers = {};
    if(token != null)
    {
      headers.addAll({'Authorization' : 'Bearer $token'});
    }
    http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Post Request Failed! , ERROR_CODE: ${response.statusCode} and body: ${jsonDecode(response.body)}',
      );
    }
  }

  // Put Request
  Future<dynamic> putRequest({required String url, required body, String? token}) async
  {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if(token != null){
      headers.addAll({'Authorization' : 'Bearer $token'});
    }
    http.Response response = await http.put(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else{
      throw Exception(
        'Put Request Failed! , ERROR_CODE: ${response.statusCode} and body: ${jsonDecode(response.body)}',
      );
    }
  }
}