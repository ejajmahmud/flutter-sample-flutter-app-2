import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sample_flutter_app/helpers/api/api_base_helper.dart';
import 'package:sample_flutter_app/helpers/api/api_exception.dart';
import 'package:sample_flutter_app/helpers/api/api_response.dart';
import 'package:sample_flutter_app/models/auth/auth_credentials.dart';
import 'package:sample_flutter_app/models/auth/auth_payload.dart';
import 'package:sample_flutter_app/models/auth/register_request.dart';
import 'package:sample_flutter_app/models/user.dart';

class AuthRepository {
  static ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<String> attemptAutoLogin() async {
    await Future.delayed(Duration(seconds: 1));
    throw Exception('not signed in');
  }

  Future<AuthPayload> login(AuthBasicCredentials credentials) async {
    final ApiResponse apiResponse = await _apiBaseHelper.post(
        "https://test.sukithasagayo.com/api/caregiver/login",json.encode(credentials));
    try{
      AuthPayload authPayload = AuthPayload.fromJson(jsonDecode(apiResponse.data));
      return authPayload;
    }catch(e){
      print(e.toString());
      throw InvalidServerResponseException(e.toString());
    }
  }

  Future<ApiResponse> register(RegisterRequest registerRequest) async {
    final ApiResponse apiResponse = await _apiBaseHelper.post(
        "https://test.sukithasagayo.com/api/caregiver/register",json.encode(registerRequest));
    return apiResponse;
  }

  confirm(AuthBasicCredentials authBasicCredentials) {}
}
