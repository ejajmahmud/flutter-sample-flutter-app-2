import 'package:equatable/equatable.dart';

abstract class FormSubmissionStatus extends Equatable {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();

  @override
  List<Object?> get props => [];
}

class FormSubmitting extends FormSubmissionStatus {
  @override
  List<Object?> get props => [];
}

class SubmissionSuccess extends FormSubmissionStatus {
  @override
  List<Object?> get props => [];
}

class SubmissionFailed extends FormSubmissionStatus {
  final Object exception;
  SubmissionFailed(this.exception);

  @override
  List<Object?> get props => [];
}
