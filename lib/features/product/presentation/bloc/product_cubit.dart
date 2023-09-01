import 'package:ecomm/features/product/domain/entities/entities.dart';
import 'package:ecomm/features/product/domain/usecases/get_product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required GetProductUseCase getProductUseCase,
  })  : _getProductUseCase = getProductUseCase,
        super(const ProductState.initial());

  final GetProductUseCase _getProductUseCase;

  Future<void> load({required String productId}) async {
    emit(state.copyWith(status: ProductStatus.loading));

    final productEither = await _getProductUseCase.call(Params(id: productId));

    productEither.fold(
      (failure) {
        failure is ProductNotFoundFailure
            ? emit(state.copyWith(status: ProductStatus.notFound))
            : emit(state.copyWith(status: ProductStatus.failure));
      },
      (product) {
        emit(state.copyWith(status: ProductStatus.success, product: product));
      },
    );
  }

  Future<void> setQuantity(int quantity) async {
    emit(state.copyWith(quantity: quantity));
  }

  Future<void> decrementQuantity() async {
    emit(state.copyWith(quantity: state.quantity - 1));
  }
}
