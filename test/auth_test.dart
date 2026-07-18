// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample_flutter_app/controllers/auth/auth_cubit.dart';
import 'package:sample_flutter_app/controllers/theme/theme_cubit.dart';
import 'package:sample_flutter_app/models/auth/auth_payload.dart';
import 'package:sample_flutter_app/models/user.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory(),
  );

  group('Test Auth', () {

    blocTest(
      'Emit [] when not toggled',
      build: () =>AuthCubit(),
      expect: () => [],
    );

    blocTest(
      'Emit [Authenticated()] when authenticate',
      build: () => AuthCubit(),
      act: (AuthCubit cubit) => cubit.authenticate(AuthPayload(token: "token", user: User(phone: "phone", name: "name", email: "email"))),
      expect: () => [Authenticated(user: User(phone: "phone", name: "name", email: "email"), token: "token")],
    );

    blocTest(
      'Emit [Authenticated()] when authenticate twice',
      build: () => AuthCubit(),
      act: (AuthCubit cubit){
        cubit.authenticate(AuthPayload(token: "token", user: User(phone: "phone", name: "name", email: "email")));
        cubit.authenticate(AuthPayload(token: "token", user: User(phone: "phone", name: "name", email: "email")));
      },
      expect: () => [Authenticated(user: User(phone: "phone", name: "name", email: "email"), token: "token")],
    );

    blocTest(
      'Emit [Unauthenticated()] when unauthenticate',
      build: () => AuthCubit(),
      act: (AuthCubit cubit){
        cubit.unauthenticate();
      },
      expect: () => [Unauthenticated()],
    );

    blocTest(
      'Emit [Unauthenticated()] when unauthenticate twice',
      build: () => AuthCubit(),
      act: (AuthCubit cubit){
        cubit.unauthenticate();
        cubit.unauthenticate();
      },
      expect: () => [Unauthenticated()],
    );

    // blocTest(
    //   'Emit [DarkTheme(), ThemeLight()] when toggled twice',
    //   build: () => AuthCubit(),
    //   act: (AuthCubit cubit) {
    //     cubit.toggleTheme();
    //     cubit.toggleTheme();
    //   },
    //   expect: () => [ThemeDark(),ThemeLight()],
    // );
  });
}
