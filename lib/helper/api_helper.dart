import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class Api {
  // Get Request
  Future<dynamic> get({required String url, String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    if (url.contains('categories')) {
      log('Get Category Request: url = $url, token= $token');
    } else {
      log('Get Products Request: url = $url, token= $token');
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
  Future<dynamic> post(
      {required String url, required dynamic body, String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    log('Post Request: url = $url, body= $body, token= $token');
    http.Response response =
        await http.post(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
        'Post Request Failed! , ERROR_CODE: ${response.statusCode} and body: ${jsonDecode(response.body)}',
      );
    }
  }

  // Put Request
  Future<dynamic> put(
      {required String url, required dynamic body, String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    log('Put Request: url = $url, body= $body, token= $token');
    http.Response response =
        await http.put(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Put Request Failed! , ERROR_CODE: ${response.statusCode} and body: ${jsonDecode(response.body)}',
      );
    }
  }

  // Delete Request
  Future<dynamic> delete({required String url, String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    log('Delete Request: url = $url, token= $token');
    http.Response response =
        await http.delete(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Delete Request Failed! , ERROR_CODE: ${response.statusCode} and body: ${jsonDecode(response.body)}',
      );
    }
  }
}
