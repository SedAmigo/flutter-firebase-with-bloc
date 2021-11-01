import 'package:formz/formz.dart';

enum EmailValidator { invalid }
enum PasswordValidator { invalid }
enum ConfirmPasswordValidator { invalid }

class Email extends FormzInput<String, EmailValidator> {
  Email.pure([String value = '']) : super.pure(value);
  Email.dirty([String value = '']) : super.dirty(value);

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidator? validator(String? value) {
    return _emailRegex.hasMatch(value ?? '') ? null : EmailValidator.invalid;
  }
}

class Password extends FormzInput<String, PasswordValidator> {
  Password.prre([String value = '']) : super.pure(value);
  Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegex = RegExp(
      r'^(?=\D*\d)(?=.*[A-Za-z])[\w~@#$%^&*+=`|{}:;!.?\"()\[\]-]{8,25}$');

  @override
  PasswordValidator? validator(String? value) {
    return _passwordRegex.hasMatch(value ?? '')
        ? null
        : PasswordValidator.invalid;
  }
}
