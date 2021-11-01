part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  final String loadinMessage;

  const LoginLoading({required this.loadinMessage});

  @override
  List<Object> get props => [loadinMessage];
}

class LoggedIn extends LoginState {
  final User user;

  const LoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginError extends LoginState {
  final String errormessage;

  const LoginError({required this.errormessage});

  @override
  List<Object> get props => [errormessage];
}
