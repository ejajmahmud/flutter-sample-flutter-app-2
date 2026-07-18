import 'package:equatable/equatable.dart';

class User extends Equatable {
  String phone = '';
  String name = '';
  String email = '';

  User(
      {required this.phone,
        required this.name,
        required this.email});

  @override
  User.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
  }

  Map toJson() {
    Map jsonData = {
      "phone": phone,
      "name": name,
      "email": email,
    };
    return jsonData;
  }

  static pure() {
    return User(phone: '', name: '', email: '');
  }

  @override
  List<Object?> get props => [name, phone, email];
}
