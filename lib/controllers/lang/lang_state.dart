part of 'lang_cubit.dart';

@immutable
abstract class LangState extends Equatable {
  final Locale locale;

  LangState(this.locale);

}

class LangEn extends LangState {
  LangEn() : super(Locale("en"));

  @override
  List<Object?> get props => [];
}

class LangSi extends LangState {
  LangSi() : super(Locale("si"));

  @override
  List<Object?> get props => [];
}