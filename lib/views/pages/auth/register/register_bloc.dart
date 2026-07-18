import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sample_flutter_app/controllers/auth/auth_cubit.dart';
import 'package:sample_flutter_app/controllers/nav/auth/auth_nav_cubit.dart';
import 'package:sample_flutter_app/controllers/nav/nav_cubit.dart';
import 'package:sample_flutter_app/data/repositories/auth_repository.dart';
import 'package:sample_flutter_app/helpers/api/api_response.dart';
import 'package:sample_flutter_app/helpers/forms/form_submission_status.dart';
import 'package:sample_flutter_app/models/auth/auth_credentials.dart';
import 'package:sample_flutter_app/models/auth/auth_payload.dart';
import 'package:sample_flutter_app/models/auth/register_request.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepo;
  final AuthNavCubit authNavCubit;

  RegisterBloc({required this.authRepo, required this.authNavCubit})
      : super(RegisterState());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterNameChanged) {
      yield state.copyWith(name: event.name);
      // Password updated
    } else if (event is RegisterPhoneChanged) {
      yield state.copyWith(phone: event.phone);
      // Password updated
    } else if (event is RegisterEmailChanged) {
      yield state.copyWith(email: event.email);
      // Password updated
    } else if (event is RegisterPasswordChanged) {
      yield state.copyWith(password: event.password);
      // Form submitted
    } else if (event is RegisterSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final ApiResponse apiResponse = await authRepo.register(RegisterRequest(
            phone: state.phone,
            name: state.name,
            email: state.email,
            password: state.password));

        authNavCubit.showConfirm();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (exception) {
        yield state.copyWith(formStatus: SubmissionFailed(exception));
      }
    }
  }
}
