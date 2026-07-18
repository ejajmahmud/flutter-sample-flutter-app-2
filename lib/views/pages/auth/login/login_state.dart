part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String phone;

  //bool get isValidPhone => phone.length > 3;

  final String password;

  //bool get isValidPassword => password.length > 6;

  final FormSubmissionStatus formStatus;

  LoginState({
    this.phone = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? phone,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [phone, password, formStatus];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState &&
          runtimeType == other.runtimeType &&
          this.phone == other.phone &&
          this.password == other.password &&
          this.formStatus == other.formStatus;

  @override
  int get hashCode => (this.phone+this.password+this.formStatus.toString()).hashCode;
}
