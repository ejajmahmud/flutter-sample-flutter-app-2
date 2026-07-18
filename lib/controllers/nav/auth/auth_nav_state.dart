part of 'auth_nav_cubit.dart';

abstract class AuthNavState extends Equatable {
  final String route;
  const AuthNavState(this.route);
}

class AuthNavLogin extends AuthNavState {
  AuthNavLogin() : super("/login");

  @override
  List<Object> get props => [];
}

class AuthNavRegister extends AuthNavState {
  AuthNavRegister() : super("/register");

  @override
  List<Object> get props => [];
}

class AuthNavConfirmRegister extends AuthNavState {
  AuthNavConfirmRegister() : super("/register/confirm");

  @override
  List<Object> get props => [];
}
