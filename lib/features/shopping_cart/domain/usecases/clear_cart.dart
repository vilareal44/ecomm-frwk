import 'package:dartz/dartz.dart';
import 'package:ecomm/core/error/failures.dart';
import 'package:ecomm/core/usecases/usecase.dart';
import 'package:ecomm/features/shopping_cart/domain/entities/entities.dart';
import 'package:ecomm/features/shopping_cart/domain/repositories/shopping_cart_repository.dart';

class ClearShoppingCartFailure extends Failure {}

class ClearShoppingCartUseCase implements NoParamUseCase<ShoppingCart> {
  ClearShoppingCartUseCase(this.repository);

  final ShoppingCartRepository repository;

  @override
  Future<Either<Failure, ShoppingCart>> call() async {
    try {
      final shoppingCart = await repository.clear();

      return Right(shoppingCart);
    } catch (error) {
      return Left(ClearShoppingCartFailure());
    }
  }
}
