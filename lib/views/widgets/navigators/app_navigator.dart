import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/controllers/nav/nav_cubit.dart';
import 'package:sample_flutter_app/views/pages/home/home_screen.dart';


class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, NavState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state is NavStateHome) MaterialPage(name:state.route, child: HomeScreen()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
