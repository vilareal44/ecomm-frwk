import 'package:dartz/dartz.dart';
import 'package:ecomm/core/error/failures.dart';
import 'package:ecomm/core/usecases/usecase.dart';
import 'package:ecomm/features/product/domain/entities/entities.dart';
import 'package:ecomm/features/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetProductFailure extends Failure {}

class ProductNotFoundFailure extends Failure {}

class GetProductUseCase implements UseCase<void, Params> {
  GetProductUseCase(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, Product>> call(Params params) async {
    try {
      final product = await repository.getById(params.id);
      if (product == null) return Left(ProductNotFoundFailure());

      return Right(product);
    } catch (error) {
      return Left(GetProductFailure());
    }
  }
}

class Params extends Equatable {
  final String id;

  const Params({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
