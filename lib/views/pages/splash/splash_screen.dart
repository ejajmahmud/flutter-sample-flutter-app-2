import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sample_flutter_app/controllers/nav/auth/auth_nav_cubit.dart';
import 'package:sample_flutter_app/controllers/nav/nav_cubit.dart';
import 'package:sample_flutter_app/views/widgets/layouts/initial_layout.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InitialLayout(child: CircularProgressIndicator());
  }
}
