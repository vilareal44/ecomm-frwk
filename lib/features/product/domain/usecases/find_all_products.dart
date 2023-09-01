import 'package:dartz/dartz.dart';
import 'package:ecomm/core/error/failures.dart';
import 'package:ecomm/core/usecases/usecase.dart';
import 'package:ecomm/features/product/domain/entities/entities.dart';
import 'package:ecomm/features/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class FindAllProductsFailure extends Failure {}

class FindProductsNotFoundFailure extends Failure {}

class FindAllProductsUseCase implements NoParamUseCase<List<Product>> {
  FindAllProductsUseCase(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, List<Product>>> call() async {
    try {
      final products = await repository.findAll();
      if (products == null || products.isEmpty) {
        return Left(FindProductsNotFoundFailure());
      }

      return Right(products);
    } catch (error) {
      return Left(FindAllProductsFailure());
    }
  }
}
