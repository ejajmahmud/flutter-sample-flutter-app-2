import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/config/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sample_flutter_app/controllers/auth/auth_cubit.dart';
import 'package:sample_flutter_app/controllers/nav/nav_cubit.dart';
import 'package:sample_flutter_app/views/widgets/navigators/init_navigator.dart';

class SampleFlutterApp extends StatelessWidget {
  final ThemeData theme;
  final Locale local;

  const SampleFlutterApp({required this.theme, required this.local});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      //initialRoute: BlocProvider.of<NavCubit>(context).state.route,
      //routes: appRoutes,
      home: InitNavigator(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: local,
    );
  }
}
