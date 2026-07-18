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
import 'package:sample_flutter_app/controllers/lang/lang_cubit.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory(),
  );

  group('Test Lang', () {

    blocTest(
      'Emit [] when not toggled',
      build: () => LangCubit(),
      expect: () => [],
    );

    blocTest(
      'Emit [LangSi()] when changedToSinhala',
      build: () => LangCubit(),
      act: (LangCubit cubit) => cubit.changeToSinhala(),
      expect: () => [LangSi()],
    );

    blocTest(
      'Emit [LangSi()] when changedToSinhala twice',
      build: () => LangCubit(),
      act: (LangCubit cubit) {
        cubit.changeToSinhala();
        cubit.changeToSinhala();
      },
      expect: () => [LangSi()],
    );

    blocTest(
      'Emit [LangEn()] when changedToEnglish',
      build: () => LangCubit(),
      act: (LangCubit cubit) => cubit.changeToEnglish(),
      expect: () => [LangEn()],
    );

    blocTest(
      'Emit [LangSi(),LangEn()] when toggled twice',
      build: () => LangCubit(),
      act: (LangCubit cubit) {
        cubit.toggleLang();
        cubit.toggleLang();
      },
      expect: () => [LangSi(),LangEn()],
    );

  });
}
