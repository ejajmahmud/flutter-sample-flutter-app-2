import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'lang_state.dart';

class LangCubit extends HydratedCubit<LangState> {
  LangCubit() : super(LangEn());

  void toggleLang() {
    emit(state.locale.languageCode == "si" ? LangEn() : LangSi());
  }

  void changeToEnglish(){
    emit(LangEn());
  }

  void changeToSinhala(){
    emit(LangSi());
  }

  @override
  LangState? fromJson(Map<String, dynamic> json) {
    if(json["locale"] == "si"){
      return LangSi();
    }
    return LangEn();
  }

  @override
  Map<String, dynamic>? toJson(LangState state) {
    if(state is LangSi){
      return {
        "locale":"si",
      };
    }
    return {
      "locale":"en",
    };
  }
}
