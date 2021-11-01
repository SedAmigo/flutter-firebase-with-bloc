part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoginFormSubmit extends AuthEvent {
  final String email;
  final String password;

  const LoginFormSubmit({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}


class Logout extends AuthEvent {}
