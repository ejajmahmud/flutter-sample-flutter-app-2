import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sample_flutter_app/helpers/api/api_exception.dart';

import 'package:sample_flutter_app/helpers/api/api_response.dart';

class ApiBaseHelper {
  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<ApiResponse> post(String url, dynamic body) async {
    Map<String, String> _headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };

    print('Api Post, url $url');
    ApiResponse apiResponse;
    try {
      final response =
          await http.post(Uri.parse(url), body: body, headers: _headers);
      print('Received a response from the server');
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return apiResponse;
  }

  Future<dynamic> put(String url, dynamic body) async {
    print('Api Put, url $url');
    var responseJson;
    try {
      final response = await http.put(Uri.parse(url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    print('Api delete, url $url');
    var apiResponse;
    try {
      final response = await http.delete(Uri.parse(url));
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }
}

ApiResponse _returnResponse(http.Response response) {
  ApiResponse apiResponse = ApiResponse(status: false, message: "", data: "");
  print(response.body.toString());
  try {
    print("json");
    var jsonObj = json.decode(response.body.toString());
    print(jsonObj);
    print("ApiResponse");
    apiResponse = ApiResponse.fromJson(jsonObj);
    print(apiResponse.toString());
    print(response.statusCode);

  } catch (e) {
    print("Error:");
    print(e);
    throw FetchDataException(
        'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
  switch (response.statusCode) {
    case 200:
      return apiResponse;
    case 400:
      throw BadRequestException(apiResponse.toString());
    case 401:
    case 403:
      throw UnauthorisedException(apiResponse.toString());
    case 422:
      throw BadRequestException(apiResponse.toString());
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
