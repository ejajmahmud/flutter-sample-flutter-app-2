import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sample_flutter_app/models/auth/auth_payload.dart';
import 'package:sample_flutter_app/models/user.dart';

part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {

  AuthCubit() : super(Unauthenticated());

  void authenticate(AuthPayload authPayload) {
    emit(Authenticated(user: authPayload.user, token: authPayload.token));
  }
  void unauthenticate() {
    emit(Unauthenticated());
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    if (json["state"] == "UnknownAuthState") {
      return UnknownAuthState();
    }
    if (json["state"] == "Unauthenticated") {
      return Unauthenticated();
    }
    if (json["state"] == "Authenticated") {
      return Authenticated(
          user: User.fromJson(jsonDecode(json["user"])), token: json["token"]);
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is UnknownAuthState) {
      return {
        "state": "UnknownAuthState",
      };
    }
    if (state is Unauthenticated) {
      return {
        "state": "Unauthenticated",
      };
    }

    if (state is Authenticated) {
      return {
        "state": "Authenticated",
        "token": state.token,
        "user": jsonEncode(state.user.toJson())
      };
    }
  }
}
