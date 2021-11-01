import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/app/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginFormSubmit>((event, emit) async {
      emit(const LoginLoading(loadinMessage: 'Logging in...'));

      try {
        final user = await authRepository.loginWithEmailandPassword(
            email: event.email, password: event.password);
        if (user != null) {
          emit(LoggedIn(user: user));
        } else {
          emit(const LoginError(errormessage: 'Some error occoured'));
        }
      } on FirebaseAuthException catch (e) {
        emit(LoginError(errormessage: e.toString()));
      } catch (e) {
        emit(LoginError(errormessage: e.toString()));
      }
    });
  }
}
