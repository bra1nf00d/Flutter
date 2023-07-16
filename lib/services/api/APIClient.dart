import 'dart:convert';
import 'package:http/http.dart' as http;

class APIClient {
  static final APIClient shared = APIClient();

  Future get({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      if (parameters != null) {
        parameters = parameters.map((key, value) => MapEntry(key, value.toString()));
      }

      var uri = Uri(
        scheme: 'https',
        host: 'jsonplaceholder.typicode.com',
        path: url,
        queryParameters: parameters,
      );

      final response = await http.get(uri, headers: headers);
      var data = json.decode(response.body);
      return data;
    } catch (e) {
      print("Request Error");
      return;
    }
  }

  Future post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      if (parameters != null) {
        parameters = parameters.map((key, value) => MapEntry(key, value.toString()));
      }

      var uri = Uri(
        scheme: 'https',
        host: 'jsonplaceholder.typicode.com',
        path: url,
        queryParameters: parameters,
      );
      var _headers = {
        "Content-Type": "application/json",
      };
      var _body = json.encode(body);

      if (headers != null) {
        _headers.addAll(headers);
      }

      var response = await http.post(uri, body: _body, headers: _headers);
      var data = json.decode(response.body);
      return data;
    } catch (e) {
      print("Request Error");
      return;
    }
  }
}