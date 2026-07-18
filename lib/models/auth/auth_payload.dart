import 'dart:convert';

import 'package:sample_flutter_app/models/user.dart';

class AuthPayload{
  String token = '';
  User user = User.pure();

  AuthPayload({required this.token, required this.user});

  AuthPayload.fromJson(Map<String, dynamic> json) {
    token = json['access_token'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() => {
    "access_token": token,
    "user": jsonEncode(user),
  };
}