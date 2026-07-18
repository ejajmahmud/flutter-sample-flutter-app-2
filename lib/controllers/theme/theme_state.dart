part of 'theme_cubit.dart';

@immutable
abstract class ThemeState extends Equatable {
  final ThemeData theme;

  ThemeState(this.theme);
}

class ThemeLight extends ThemeState {
  ThemeLight() : super(lightTheme);

  @override
  List<Object?> get props => [];
}

class ThemeDark extends ThemeState {
  ThemeDark() : super(darkTheme);

  @override
  List<Object?> get props => [];
}
