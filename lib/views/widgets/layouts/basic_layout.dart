import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/config/constants.dart';
import 'package:sample_flutter_app/controllers/nav/nav_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BasicLayout extends StatelessWidget {
  String title;

  Widget child;

  BasicLayout({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.home),
                onTap: () {
                  //context.read<NavCubit>().navigate(context,"/home");
                  //Navigator.of(context).pushNamed('/');
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.login),
                onTap: () {
                  //context.read<NavCubit>().navigate(context,"/login");
                  //avigator.of(context).pushNamed('/login');
                },
              )
            ],
          ),
        ),
        body: Center(
            child: Padding(
          padding: appPadding,
          child: child,
        )));
  }
}
