import 'package:flutter/foundation.dart';

abstract class AuthCredentials {}

class AuthBasicCredentials extends AuthCredentials {
  String phone = "";
  String password = "";

  AuthBasicCredentials({required this.phone, required this.password});

  AuthBasicCredentials.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "password": password,
      };
}
