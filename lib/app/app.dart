import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/app/auth_repository.dart';
import 'package:flutter_firebase/bloc/auth/auth_bloc.dart';
import 'package:flutter_firebase/bloc/login/login_bloc.dart';
import 'package:flutter_firebase/bloc/register/register_bloc.dart';
import 'package:flutter_firebase/screens/auth/login_screen.dart';

import 'package:flutter_firebase/screens/auth/register_screen.dart';
import 'package:flutter_firebase/screens/home_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            FirebaseAuth auth = FirebaseAuth.instance;

            final authREpo = AuthRepository(auth: auth);
            return AuthBloc(authRepository: authREpo)..add(AppStarted());
          },
        ),
        BlocProvider(
          create: (context) {
            FirebaseAuth auth = FirebaseAuth.instance;

            final authREpo = AuthRepository(auth: auth);
            return RegisterBloc(authRepository: authREpo);
          },
        ),
        BlocProvider(
          create: (context) {
            FirebaseAuth auth = FirebaseAuth.instance;

            final authREpo = AuthRepository(auth: auth);
            return LoginBloc(authRepository: authREpo);
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: AlertDialog(
                  title: Row(
                    children: const [
                      CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Loading',
                      )
                    ],
                  ),
                ),
              );
            }
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Scanning is not completed!')),
              );
            }
            if (state is UserAuthenticated || state is AuthSuccess) {
              return const HomeScreen();
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
