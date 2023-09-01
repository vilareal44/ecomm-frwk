part of 'shopping_cart_cubit.dart';

enum ShoppingCartStatus {
  initial,
  loading,
  success,
  failure,
}

class ShoppingCartState extends Equatable {
  const ShoppingCartState({
    required this.status,
    this.shoppingCart,
  });

  final ShoppingCartStatus status;
  final ShoppingCart? shoppingCart;

  bool get isLoading => status == ShoppingCartStatus.loading;
  bool get isSuccess => status == ShoppingCartStatus.success;
  bool get isFailure => status == ShoppingCartStatus.failure;
  bool get isInitial => status == ShoppingCartStatus.initial;

  @override
  List<Object?> get props => [status, shoppingCart];

  const ShoppingCartState.initial() : this(status: ShoppingCartStatus.initial);

  ShoppingCartState copyWith({
    ShoppingCartStatus? status,
    ShoppingCart? shoppingCart,
  }) {
    return ShoppingCartState(
      status: status ?? this.status,
      shoppingCart: shoppingCart ?? this.shoppingCart,
    );
  }
}
