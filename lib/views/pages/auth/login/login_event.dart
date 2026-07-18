part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginPhoneChanged extends LoginEvent {
  final String phone;

  LoginPhoneChanged({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});

  @override
  List<Object?> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  @override
  List<Object?> get props => [];
}