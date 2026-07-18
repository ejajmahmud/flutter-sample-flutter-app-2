import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sample_flutter_app/controllers/auth/auth_cubit.dart';
import 'package:sample_flutter_app/data/repositories/auth_repository.dart';
import 'package:sample_flutter_app/helpers/forms/form_submission_status.dart';
import 'package:sample_flutter_app/models/auth/auth_credentials.dart';
import 'package:sample_flutter_app/models/auth/auth_payload.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepo, required this.authCubit}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginPhoneChanged) {
      yield state.copyWith(phone: event.phone);
      // Password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final AuthPayload authPayload = await authRepo.login(AuthBasicCredentials(phone: state.phone, password: state.password));

        authCubit.authenticate(authPayload);

        yield state.copyWith(formStatus: SubmissionSuccess());

      }catch(exception){
        yield state.copyWith(formStatus: SubmissionFailed(exception));
      }
    }
  }
}
