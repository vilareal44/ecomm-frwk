import 'package:ecomm/features/product/domain/entities/entities.dart';
import 'package:ecomm/features/shopping_cart/domain/entities/entities.dart';
import 'package:ecomm/features/shopping_cart/domain/usecases/usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shopping_cart_state.dart';

class ShoppingCartCubit extends Cubit<ShoppingCartState> {
  ShoppingCartCubit({
    required GetShoppingCartUseCase getShoppingCartUseCase,
    required ClearShoppingCartUseCase clearShoppingCartUseCase,
    required AddToCartUseCase addToCartUseCase,
  })  : _getShoppingCartUseCase = getShoppingCartUseCase,
        _clearShoppingCartUseCase = clearShoppingCartUseCase,
        _addToCartUseCase = addToCartUseCase,
        super(const ShoppingCartState.initial());

  final GetShoppingCartUseCase _getShoppingCartUseCase;
  final ClearShoppingCartUseCase _clearShoppingCartUseCase;
  final AddToCartUseCase _addToCartUseCase;

  Future<void> load() async {
    emit(state.copyWith(status: ShoppingCartStatus.loading));

    final shoppingCartEither = await _getShoppingCartUseCase.call();

    shoppingCartEither.fold(
      (failure) {
        emit(state.copyWith(status: ShoppingCartStatus.failure));
      },
      (shoppingCart) {
        emit(state.copyWith(
            status: ShoppingCartStatus.success, shoppingCart: shoppingCart));
      },
    );
  }

  Future<void> clear() async {
    emit(state.copyWith(status: ShoppingCartStatus.loading));

    final shoppingCartEither = await _clearShoppingCartUseCase.call();

    shoppingCartEither.fold(
      (failure) {
        emit(state.copyWith(status: ShoppingCartStatus.failure));
      },
      (shoppingCart) {
        emit(state.copyWith(
            status: ShoppingCartStatus.success, shoppingCart: shoppingCart));
      },
    );
  }

  Future<void> add({required Product product, required int quantity}) async {
    emit(state.copyWith(status: ShoppingCartStatus.loading));

    final shoppingCartEither = await _addToCartUseCase.call(Params(
      product: product,
      quantity: quantity,
    ));

    shoppingCartEither.fold(
      (failure) {
        emit(state.copyWith(status: ShoppingCartStatus.failure));
      },
      (shoppingCart) {
        emit(state.copyWith(
            status: ShoppingCartStatus.success, shoppingCart: shoppingCart));
      },
    );
  }
}
