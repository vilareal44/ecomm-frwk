import 'dart:async';

import 'models/authentication_user.dart';

abstract class AuthenticationException implements Exception {
  const AuthenticationException(this.error);

  final Object error;
}

class SendPasswordResetEmailFailure extends AuthenticationException {
  const SendPasswordResetEmailFailure(super.error);
}

class LogOutFailure extends AuthenticationException {
  const LogOutFailure(super.error);
}

class LogInWithEmailAndPasswordFailure extends AuthenticationException {
  const LogInWithEmailAndPasswordFailure(super.error);
}

class SignUpWithEmailAndPasswordFailure extends AuthenticationException {
  const SignUpWithEmailAndPasswordFailure(super.error);
}

abstract class AuthenticationClient {
  Stream<AuthenticationUser> get user;

  Future<void> logInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<void> logOut();
}
