part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {
  final String loadinMessage;

  const RegisterLoading({required this.loadinMessage});

  @override
  List<Object> get props => [loadinMessage];
}

class Registerd extends RegisterState {
  final User user;

  const Registerd({required this.user});

  @override
  List<Object> get props => [user];
}

class RegisterError extends RegisterState {
  final String errormessage;

  const RegisterError({required this.errormessage});

  @override
  List<Object> get props => [errormessage];
}
