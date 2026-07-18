import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sample_flutter_app/controllers/auth/auth_cubit.dart';
import 'package:sample_flutter_app/controllers/lang/lang_cubit.dart';
import 'package:sample_flutter_app/controllers/theme/theme_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sample_flutter_app/views/pages/home/home_bloc.dart';
import 'package:sample_flutter_app/views/widgets/layouts/basic_layout.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          HomeBloc(authCubit: context.read<AuthCubit>()),
      child: BasicLayout(
        title: AppLocalizations.of(context)!.home,
        child: content(context),
      ),
    );
  }

  Widget content(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        _showSnackBar(context, state.toString());
      },
      child: Column(
        children: [
          FloatingActionButton(
            child: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            heroTag: "themeBtn",
          ),
          FloatingActionButton(
            child: Text(AppLocalizations.of(context)!.firstLetter),
            onPressed: () => context.read<LangCubit>().toggleLang(),
            heroTag: "langBtn",
          ),
          BlocBuilder<AuthCubit,AuthState>(builder: (context,state){
            if(state is Authenticated){
              return Text(state.user.name);
            }
            return Text("User has not been authenticated");
          }),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
