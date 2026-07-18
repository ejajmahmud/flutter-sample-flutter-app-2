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
import 'package:sample_flutter_app/controllers/theme/theme_cubit.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory(),
  );

  group('Test Theme', () {

    blocTest(
      'Emit [] when not toggled',
      build: () => ThemeCubit(),
      expect: () => [],
    );

    blocTest(
      'Emit [ThemeDark()] when changeToDark',
      build: () => ThemeCubit(),
      act: (ThemeCubit cubit) => cubit.changeToDark(),
      expect: () => [ThemeDark()],
    );

    blocTest(
      'Emit [ThemeDark()] when changeToDark twice',
      build: () => ThemeCubit(),
      act: (ThemeCubit cubit){
        cubit.changeToDark();
        cubit.changeToDark();
      },
      expect: () => [ThemeDark()],
    );

    blocTest(
      'Emit [ThemeDark()] when changeToLight',
      build: () => ThemeCubit(),
      act: (ThemeCubit cubit) => cubit.changeToLight(),
      expect: () => [ThemeLight()],
    );

    // blocTest(
    //   'Emit [DarkTheme(), ThemeLight()] when toggled twice',
    //   build: () => ThemeCubit(),
    //   act: (ThemeCubit cubit) {
    //     cubit.toggleTheme();
    //     cubit.toggleTheme();
    //   },
    //   expect: () => [ThemeDark(),ThemeLight()],
    // );
  });
}
