import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sample_flutter_app/config/constants.dart';

class InitialLayout extends StatelessWidget {
  final Widget child;

  InitialLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
              padding: appPadding,
              child: child,
    )));
  }
}
