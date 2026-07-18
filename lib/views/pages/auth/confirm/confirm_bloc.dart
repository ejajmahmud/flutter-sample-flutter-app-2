import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sample_flutter_app/controllers/auth/auth_cubit.dart';
import 'package:sample_flutter_app/controllers/nav/nav_cubit.dart';
import 'package:sample_flutter_app/data/repositories/auth_repository.dart';
import 'package:sample_flutter_app/helpers/forms/form_submission_status.dart';
import 'package:sample_flutter_app/models/auth/auth_credentials.dart';
import 'package:sample_flutter_app/models/auth/auth_payload.dart';

part 'confirm_event.dart';
part 'confirm_state.dart';

class ConfirmBloc extends Bloc<ConfirmEvent, ConfirmState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmBloc({required this.authRepo, required this.authCubit}) : super(ConfirmState());

  @override
  Stream<ConfirmState> mapEventToState(
    ConfirmEvent event,
  ) async* {
    if (event is ConfirmPhoneChanged) {
      yield state.copyWith(phone: event.phone);
      // Password updated
    } else if (event is ConfirmPasswordChanged) {
      yield state.copyWith(password: event.password);
      // Form submitted
    } else if (event is ConfirmSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final AuthPayload authPayload = await authRepo.confirm(AuthBasicCredentials(phone: state.phone, password: state.password));

        authCubit.authenticate(authPayload);

        yield state.copyWith(formStatus: SubmissionSuccess());

      }catch(exception){
        yield state.copyWith(formStatus: SubmissionFailed(exception));
      }
    }
  }
}
