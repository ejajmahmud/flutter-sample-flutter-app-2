part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterPhoneChanged extends RegisterEvent {
  final String phone;

  RegisterPhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  RegisterEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}


class RegisterNameChanged extends RegisterEvent {
  final String name;

  RegisterNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class RegisterSubmitted extends RegisterEvent {
  @override
  List<Object?> get props => [];
}