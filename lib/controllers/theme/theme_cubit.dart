import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sample_flutter_app/config/themes.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeLight());

  void toggleTheme() {
    emit(
        state.theme.brightness == Brightness.dark ? ThemeLight() : ThemeDark());
  }

  void changeToLight(){
    emit(ThemeLight());
  }

  void changeToDark(){
    emit(ThemeDark());
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    if (json["theme"] == "darkTheme") {
      return ThemeDark();
    }
    return ThemeLight();
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    if (state is ThemeDark) {
      return {"theme": "darkTheme"};
    }
    return {"theme": "lightTheme"};
  }
}
