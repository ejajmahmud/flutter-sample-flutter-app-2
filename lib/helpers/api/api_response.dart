import 'dart:convert';

class ApiResponse {
  bool status = false;
  String message = "";
  String data = "";

  ApiResponse({required this.status, required this.message, required this.data });

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }

  ApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = jsonEncode(json["data"]);
  }
}

