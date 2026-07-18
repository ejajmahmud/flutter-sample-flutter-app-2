import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sample_flutter_app/views/sample_flutter_app.dart';
import 'package:path_provider/path_provider.dart';
import 'controllers/auth/auth_cubit.dart';
import 'controllers/lang/lang_cubit.dart';
import 'controllers/theme/theme_cubit.dart';
import 'data/repositories/auth_repository.dart';
import 'helpers/log_bloc_observer.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  Bloc.observer = LogBlocObserver();

  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (BuildContext context) => ThemeCubit(),
          ),
          BlocProvider<LangCubit>(
            create: (BuildContext context) => LangCubit(),
          ),
          BlocProvider<AuthCubit>(
            create: (BuildContext context) => AuthCubit(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (_, themeState) {
            return BlocBuilder<LangCubit, LangState>(
              builder: (_, langState) {
                return SampleFlutterApp(
                  local: langState.locale,
                  theme: themeState.theme,
                );
              },
            );
          },
        ),
      )));
}
