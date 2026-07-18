// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample_flutter_app/controllers/auth/auth_cubit.dart';
import 'package:sample_flutter_app/data/repositories/auth_repository.dart';
import 'package:sample_flutter_app/helpers/forms/form_submission_status.dart';
import 'package:sample_flutter_app/views/pages/auth/login/login_bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  group('Test Login Screen', () {
    blocTest(
      'Emit [] when no event is triggered',
      build: () =>
          LoginBloc(authRepo: AuthRepository(), authCubit: AuthCubit()),
      expect: () => [],
    );

    blocTest(
      'Emit [LoginState(phone: "94702663355")] when LoginPhoneChanged is triggered',
      build: () =>
          LoginBloc(authRepo: AuthRepository(), authCubit: AuthCubit()),
      act: (LoginBloc bloc) =>
          bloc.add(LoginPhoneChanged(phone: '94702663355')),
      expect: () => [LoginState(phone: '94702663355')],
    );

    blocTest(
      'Emit [LoginState(password: "password@123") ] when LoginPasswordChanged is triggered',
      build: () =>
          LoginBloc(authRepo: AuthRepository(), authCubit: AuthCubit()),
      act: (LoginBloc bloc) =>
          bloc.add(LoginPasswordChanged(password: 'password@123')),
      expect: () => [LoginState(password: 'password@123')],
    );

    blocTest(
      'Emit [LoginState(formStatus: FormSubmitting()), LoginState(formStatus: SubmissionFailed(Exception))] when LoginSubmitted is triggered with invalid data',
      build: () =>
          LoginBloc(authRepo: AuthRepository(), authCubit: AuthCubit()),
      act: (LoginBloc bloc) => bloc.add(LoginSubmitted()),
      expect: () => [
        LoginState(formStatus: FormSubmitting()),
        LoginState(formStatus: SubmissionFailed(Exception))
      ],
    );

    blocTest(
      'Emit [LoginState(phone: "94702663355"),LoginState(phone: "94702663355",password: "password@123") ,LoginState(formStatus: FormSubmitting(), phone: "94702663355", password: "password@123"),LoginState(formStatus: SubmissionSuccess(), phone: "94702663355", password: "password@123")] when LoginSubmitted is triggered with invalid data',
      build: () =>
          LoginBloc(authRepo: AuthRepository(), authCubit: AuthCubit()),
      act: (LoginBloc bloc) {
        bloc.add(LoginPhoneChanged(phone: '94702663355'));
        bloc.add(LoginPasswordChanged(password: 'password@123'));
        bloc.add(LoginSubmitted());
      },
      expect: () => [
        LoginState(phone: "94702663355"),
        LoginState(phone: "94702663355", password: "password@123"),
        LoginState(
            formStatus: FormSubmitting(),
            phone: "94702663355",
            password: "password@123"),
        LoginState(
            formStatus: SubmissionSuccess(),
            phone: "94702663355",
            password: "password@123")
      ],
    );
  });
}
