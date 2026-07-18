part of 'confirm_bloc.dart';

class ConfirmState extends Equatable {
  final String phone;

  //bool get isValidPhone => phone.length > 3;

  final String password;

  //bool get isValidPassword => password.length > 6;

  final FormSubmissionStatus formStatus;

  ConfirmState({
    this.phone = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  ConfirmState copyWith({
    String? phone,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return ConfirmState(
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
      other is ConfirmState &&
          runtimeType == other.runtimeType &&
          this.phone == other.phone &&
          this.password == other.password &&
          this.formStatus == other.formStatus;

  @override
  int get hashCode => (this.phone+this.password+this.formStatus.toString()).hashCode;
}
