class RegisterRequest {
  String phone = '';
  String name = '';
  String email = '';
  String password = '';

  RegisterRequest({
    required this.phone,
    required this.name,
    required this.email,
    required this.password,
  });

  Map toJson() => {
        "phone": phone,
        "name": name,
        "email": email,
        "password": password
      };
}
