import 'package:dartz/dartz.dart';
import 'package:ecomm/core/error/failures.dart';
import 'package:ecomm/core/usecases/usecase.dart';
import 'package:ecomm/features/product/domain/entities/entities.dart';
import 'package:ecomm/features/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class SearchProductFailure extends Failure {}

class ProductsNotFoundFailure extends Failure {}

class SearchProductUseCase implements UseCase<List<Product>, Params> {
  SearchProductUseCase(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, List<Product>>> call(Params params) async {
    try {
      final products = await repository.search(params.query);
      if (products == null || products.isEmpty) {
        return Left(ProductsNotFoundFailure());
      }

      return Right(products);
    } catch (error) {
      return Left(SearchProductFailure());
    }
  }
}

class Params extends Equatable {
  final String query;

  const Params({
    required this.query,
  });

  @override
  List<Object> get props => [query];
}
