import 'package:dartz/dartz.dart';
import 'package:ecomm/core/error/failures.dart';
import 'package:ecomm/core/usecases/usecase.dart';
import 'package:ecomm/features/product/domain/entities/entities.dart';
import 'package:ecomm/features/product/domain/repositories/product_repository.dart';
import 'package:ecomm/features/shopping_cart/domain/entities/entities.dart';
import 'package:ecomm/features/shopping_cart/domain/repositories/shopping_cart_repository.dart';
import 'package:equatable/equatable.dart';

class AddToCartFailure extends Failure {}

class AddToCartUseCase implements UseCase<void, Params> {
  AddToCartUseCase(this.repository);

  final ShoppingCartRepository repository;

  @override
  Future<Either<Failure, ShoppingCart>> call(Params params) async {
    try {
      final shoppingCart = await repository.add(
        product: params.product,
        quantity: params.quantity,
      );

      return Right(shoppingCart);
    } catch (error) {
      return Left(AddToCartFailure());
    }
  }
}

class Params extends Equatable {
  final Product product;
  final int quantity;

  const Params({required this.product, required this.quantity});

  @override
  List<Object> get props => [product, quantity];
}
