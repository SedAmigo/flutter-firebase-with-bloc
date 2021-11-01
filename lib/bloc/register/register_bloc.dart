import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/app/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  RegisterBloc({required this.authRepository}) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {});
    on<RegisterFormSubmit>((event, emit) async {
      emit(const RegisterLoading(loadinMessage: 'Registering...'));

      try {
        final user = await authRepository.registerWithandPassword(
            email: event.email, password: event.password);
        if (user != null) {
          emit(Registerd(user: user));
        } else {
          emit(const RegisterError(errormessage: 'Some error occoured'));
        }
      } on FirebaseAuthException catch (e) {
        emit(RegisterError(errormessage: e.toString()));
      } catch (e) {
        emit(RegisterError(errormessage: e.toString()));
      }
    });
  }
}
