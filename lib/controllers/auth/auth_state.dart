part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

}

class UnknownAuthState extends AuthState {
  const UnknownAuthState();

  @override
  List<Object?> get props => [];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();

  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  final String token;
  final User user;

  const Authenticated({required this.token, required this.user});

  @override
  List<Object?> get props => [user, token];
}
