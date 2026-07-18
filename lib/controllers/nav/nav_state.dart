part of 'nav_cubit.dart';

abstract class NavState extends Equatable {
  final String route;

  NavState(this.route);
}

class NavStateHome extends NavState{
  NavStateHome() : super("/home");


  @override
  List<Object?> get props => [];
}