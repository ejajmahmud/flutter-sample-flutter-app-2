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
import 'package:sample_flutter_app/controllers/nav/auth/auth_nav_cubit.dart';
import 'package:sample_flutter_app/data/repositories/auth_repository.dart';
import 'package:sample_flutter_app/helpers/forms/form_submission_status.dart';
import 'package:sample_flutter_app/views/pages/auth/register/register_bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  group('Test Register Screen', () {
    blocTest(
      'Emit [] when no event is triggered',
      build: () => RegisterBloc(
          authRepo: AuthRepository(), authNavCubit: AuthNavCubit()),
      expect: () => [],
    );

    blocTest(
      'Emit [RegisterState(phone: "94702662255")] when RegisterPhoneChanged is triggered',
      build: () => RegisterBloc(
          authRepo: AuthRepository(), authNavCubit: AuthNavCubit()),
      act: (RegisterBloc bloc) => bloc.add(RegisterPhoneChanged('94702663355')),
      expect: () => [RegisterState(phone: '94702662255')],
    );

    blocTest(
      'Emit [RegisterState(email: "test@sukithasagayo.com")] when RegisterEmailChanged is triggered',
      build: () => RegisterBloc(
          authRepo: AuthRepository(), authNavCubit: AuthNavCubit()),
      act: (RegisterBloc bloc) =>
          bloc.add(RegisterEmailChanged('test@sukithasagayo.com')),
      expect: () => [RegisterState(email: 'test@sukithasagayo.com')],
    );

    blocTest(
      'Emit [RegisterState(name: "San Shi")] when RegisterNameChanged is triggered',
      build: () => RegisterBloc(
          authRepo: AuthRepository(), authNavCubit: AuthNavCubit()),
      act: (RegisterBloc bloc) => bloc.add(RegisterNameChanged('San Shi')),
      expect: () => [RegisterState(name: 'San Shi')],
    );

    blocTest(
      'Emit [RegisterState(password: "password@123") ] when RegisterPasswordChanged is triggered',
      build: () => RegisterBloc(
          authRepo: AuthRepository(), authNavCubit: AuthNavCubit()),
      act: (RegisterBloc bloc) =>
          bloc.add(RegisterPasswordChanged('password@123')),
      expect: () => [RegisterState(password: 'password@123')],
    );

    blocTest(
      'Emit [RegisterState(formStatus: FormSubmitting()), RegisterState(formStatus: SubmissionFailed(Exception))] when RegisterSubmitted is triggered with invalid data',
      build: () => RegisterBloc(
          authRepo: AuthRepository(), authNavCubit: AuthNavCubit()),
      act: (RegisterBloc bloc) => bloc.add(RegisterSubmitted()),
      expect: () => [
        RegisterState(formStatus: FormSubmitting()),
        RegisterState(formStatus: SubmissionFailed(Exception))
      ],
    );

    blocTest(
      'Emit [RegisterState(phone: "94702662255"),RegisterState(phone: "94702662255",password: "password@123") ,RegisterState(formStatus: FormSubmitting(), phone: "94702662255", password: "password@123"),RegisterState(formStatus: SubmissionSuccess(), phone: "94702663355", password: "password@123")] when RegisterSubmitted is triggered with invalid data',
      build: () => RegisterBloc(
          authRepo: AuthRepository(), authNavCubit: AuthNavCubit()),
      act: (RegisterBloc bloc) {
        bloc.add(RegisterNameChanged('San Shi'));
        bloc.add(RegisterPhoneChanged('94702662255'));
        bloc.add(RegisterEmailChanged('test4@sukithasagayo.com'));
        bloc.add(RegisterPasswordChanged('password@123'));
        bloc.add(RegisterSubmitted());
      },
      expect: () => [
        RegisterState(name: "San Shi"),
        RegisterState(name: "San Shi", phone: "94702662255"),
        RegisterState(
            name: "San Shi",
            phone: "94702662255",
            email: "test4@sukithasagayo.com"),
        RegisterState(
            name: "San Shi",
            phone: "94702662255",
            email: "test4@sukithasagayo.com",
            password: "password@123"),
        RegisterState(
          name: "San Shi",
          phone: "94702662255",
          email: "test4@sukithasagayo.com",
          password: "password@123",
          formStatus: FormSubmitting(),
        ),
        RegisterState(
          name: "San Shi",
          phone: "94702662255",
          email: "test4@sukithasagayo.com",
          password: "password@123",
          formStatus: SubmissionSuccess(),
        )
      ],
    );
  });
}
