part of 'product_cubit.dart';

enum ProductStatus {
  initial,
  loading,
  success,
  notFound,
  failure,
}

class ProductState extends Equatable {
  const ProductState({
    required this.status,
    this.product,
    this.quantity = 0,
  });

  final ProductStatus status;
  final Product? product;
  final int quantity;

  bool get isLoading => status == ProductStatus.loading;
  bool get isSuccess => status == ProductStatus.success;
  bool get isFailure => status == ProductStatus.failure;
  bool get isInitial => status == ProductStatus.initial;
  bool get isNotFound => status == ProductStatus.notFound;

  @override
  List<Object?> get props => [status, product, quantity];

  const ProductState.initial() : this(status: ProductStatus.initial);

  ProductState copyWith({
    ProductStatus? status,
    Product? product,
    int? quantity,
  }) {
    return ProductState(
      status: status ?? this.status,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
