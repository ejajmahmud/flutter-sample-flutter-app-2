import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_nav_state.dart';

class AuthNavCubit extends Cubit<AuthNavState> {
  AuthNavCubit() : super(AuthNavLogin());

  void showLogin() => emit(AuthNavLogin());

  void showConfirm() => emit(AuthNavConfirmRegister());
}
