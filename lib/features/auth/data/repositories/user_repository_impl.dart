import 'dart:async';

import 'package:ecomm/features/auth/domain/entities/entities.dart';
import 'package:ecomm/features/auth/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import '../authentication_client/authentication_client.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required AuthenticationClient authenticationClient,
  }) : _authenticationClient = authenticationClient;

  final AuthenticationClient _authenticationClient;

  @override
  Stream<User> get user => _authenticationClient.user.map(
        (event) => User(
          id: event.id,
          name: event.name,
          email: event.email,
        ),
      );

  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authenticationClient.logInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on LogInWithEmailAndPasswordFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
          LogInWithEmailAndPasswordFailure(error), stackTrace);
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authenticationClient.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on SignUpWithEmailAndPasswordFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
          SignUpWithEmailAndPasswordFailure(error), stackTrace);
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _authenticationClient.logOut();
    } on LogOutFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }
}
