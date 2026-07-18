import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/controllers/auth/auth_cubit.dart';
import 'package:sample_flutter_app/controllers/nav/auth/auth_nav_cubit.dart';
import 'package:sample_flutter_app/views/pages/auth/confirm/confirm_screen.dart';
import 'package:sample_flutter_app/views/pages/auth/login/login_screen.dart';
import 'package:sample_flutter_app/views/pages/auth/register/register_screen.dart';
import 'package:sample_flutter_app/views/pages/home/home_screen.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthNavCubit, AuthNavState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state is AuthNavLogin)
            MaterialPage(name: state.route, child: LoginScreen()),

          if (state is AuthNavRegister
          )
            MaterialPage(name: state.route, child: RegisterScreen()),

          if (state is AuthNavConfirmRegister)
            MaterialPage(name: state.route, child: ConfirmScreen())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
