import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/controllers/auth/auth_cubit.dart';
import 'package:sample_flutter_app/controllers/nav/auth/auth_nav_cubit.dart';
import 'package:sample_flutter_app/controllers/nav/nav_cubit.dart';
import 'package:sample_flutter_app/views/pages/splash/splash_screen.dart';
import 'package:sample_flutter_app/views/widgets/navigators/auth_navigator.dart';
import 'package:sample_flutter_app/views/widgets/navigators/app_navigator.dart';

class InitNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state is UnknownAuthState)
            MaterialPage(name: "/", child: SplashScreen()),
          if (state is Unauthenticated)
            MaterialPage(
                child: BlocProvider(
                  create: (BuildContext context) => AuthNavCubit(),
                  child: AuthNavigator(),
            )),
          if (state is Authenticated)
            MaterialPage(
                child: BlocProvider(
                  create: (BuildContext context) => NavCubit(),
                  child: AppNavigator(),
            )),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
