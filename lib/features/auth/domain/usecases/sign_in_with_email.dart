import 'package:dartz/dartz.dart';
import 'package:ecomm/core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/user_repository.dart';

class SignInWithEmailFailure extends Failure {}

class SignInWithEmail implements UseCase<void, Params> {
  SignInWithEmail(this.repository);

  final UserRepository repository;

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    try {
      await repository.logInWithEmailAndPassword(
          email: params.email, password: params.password);
      return const Right(true);
    } catch (error) {
      return Left(SignInWithEmailFailure());
    }
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
