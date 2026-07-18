part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  RegisterState({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  RegisterState copyWith({
    String? name,
    String? phone,
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return RegisterState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [name,phone,email, password, formStatus];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RegisterState &&
              runtimeType == other.runtimeType &&
              this.name == other.name &&
              this.phone == other.phone &&
              this.email == other.email &&
              this.password == other.password &&
              this.formStatus == other.formStatus;

  @override
  int get hashCode => (this.name+this.phone+this.email+this.password+this.formStatus.toString()).hashCode;
}
