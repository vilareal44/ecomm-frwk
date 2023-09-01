import 'package:ecomm/app/form_inputs/form_inputs.dart';
import 'package:ecomm/features/auth/domain/repositories/user_repository.dart';
import 'package:ecomm/features/product/domain/entities/entities.dart';
import 'package:ecomm/features/product/domain/usecases/find_all_products.dart';
import 'package:ecomm/features/product/domain/usecases/search_product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_state.dart';
part 'search_event.dart';

EventTransformer<Event> debounce<Event>({
  Duration duration = const Duration(milliseconds: 500),
}) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required SearchProductUseCase searchProductUseCase,
    required FindAllProductsUseCase findAllProductsUseCase,
  })  : _searchProductUseCase = searchProductUseCase,
        _findAllProductsUseCase = findAllProductsUseCase,
        super(const SearchState.initial()) {
    on<SearchQueryChanged>(_onQueryChanged, transformer: debounce());
    on<FindAllRequested>(_onFindAllRequested);
  }

  final SearchProductUseCase _searchProductUseCase;
  final FindAllProductsUseCase _findAllProductsUseCase;

  void _onQueryChanged(
      SearchQueryChanged event, Emitter<SearchState> emit) async {
    final query = SearchInput.dirty(event.query);

    emit(state.copyWith(searchInput: query));
    emit(state.copyWith(status: SearchStatus.loading));

    if (event.query.isEmpty) {
      add(const FindAllRequested());
      return;
    }

    final productsEither =
        await _searchProductUseCase.call(Params(query: event.query));

    productsEither.fold(
      (failure) {
        failure is ProductsNotFoundFailure
            ? emit(state.copyWith(status: SearchStatus.notFound))
            : emit(state.copyWith(status: SearchStatus.failure));
      },
      (products) {
        emit(state.copyWith(status: SearchStatus.success, products: products));
      },
    );
  }

  void _onFindAllRequested(
      FindAllRequested event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: SearchStatus.loading));

    final productsEither = await _findAllProductsUseCase.call();

    productsEither.fold(
      (failure) {
        failure is FindProductsNotFoundFailure
            ? emit(state.copyWith(status: SearchStatus.notFound))
            : emit(state.copyWith(status: SearchStatus.failure));
      },
      (products) {
        emit(state.copyWith(status: SearchStatus.success, products: products));
      },
    );
  }
}
