import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/app/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthLoading()) {
    on<AuthEvent>((event, emit) {});
    on<AppStarted>(
      (event, emit) async {
        emit(AuthLoading());

        try {
          final user = await authRepository.getCurrentUser();
          if (user != null) {
            emit(AuthSuccess(user: user));
          } else {
            emit(UserNotAuthenticated());
          }
        } catch (e) {
          emit(UserNotAuthenticated());
        }
      },
    );
    on<Logout>((event, emit) async {
      emit(AuthLoading());
      await authRepository.signOut();
      emit(UserNotAuthenticated());
    });
  }
}
