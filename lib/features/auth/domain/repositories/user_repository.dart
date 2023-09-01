import 'package:ecomm/core/error/failures.dart';
import 'package:equatable/equatable.dart';

import '../entities/user.dart';

abstract class UserRepository {
  Stream<User> get user;

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> logOut();
}
