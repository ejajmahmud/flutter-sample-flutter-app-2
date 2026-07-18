part of 'confirm_bloc.dart';

abstract class ConfirmEvent extends Equatable {
  const ConfirmEvent();
}

class ConfirmPhoneChanged extends ConfirmEvent {
  final String phone;

  ConfirmPhoneChanged({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class ConfirmPasswordChanged extends ConfirmEvent {
  final String password;

  ConfirmPasswordChanged({required this.password});

  @override
  List<Object?> get props => [password];
}

class ConfirmSubmitted extends ConfirmEvent {
  @override
  List<Object?> get props => [];
}