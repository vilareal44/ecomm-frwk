import 'package:dartz/dartz.dart';
import 'package:ecomm/core/error/failures.dart';
import 'package:ecomm/core/usecases/usecase.dart';
import 'package:ecomm/features/shopping_cart/domain/entities/entities.dart';
import 'package:ecomm/features/shopping_cart/domain/repositories/shopping_cart_repository.dart';

class GetShoppingCartFailure extends Failure {}

class GetShoppingCartUseCase implements NoParamUseCase<ShoppingCart> {
  GetShoppingCartUseCase(this.repository);

  final ShoppingCartRepository repository;

  @override
  Future<Either<Failure, ShoppingCart>> call() async {
    try {
      final shoppingCart = await repository.get();

      return Right(shoppingCart);
    } catch (error) {
      return Left(GetShoppingCartFailure());
    }
  }
}
