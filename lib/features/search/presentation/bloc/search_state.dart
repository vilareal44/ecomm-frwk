part of 'search_bloc.dart';

enum SearchStatus {
  initial,
  loading,
  success,
  notFound,
  failure,
}

class SearchState extends Equatable {
  const SearchState({
    required this.status,
    this.products,
    this.searchInput = const SearchInput.pure(),
  });

  final SearchStatus status;
  final List<Product>? products;
  final SearchInput searchInput;

  bool get isLoading => status == SearchStatus.loading;
  bool get isSuccess => status == SearchStatus.success;
  bool get isFailure => status == SearchStatus.failure;
  bool get isInitial => status == SearchStatus.initial;
  bool get isNotFound => status == SearchStatus.notFound;

  @override
  List<Object?> get props => [status, products, searchInput];

  const SearchState.initial() : this(status: SearchStatus.initial);

  SearchState copyWith({
    SearchStatus? status,
    List<Product>? products,
    SearchInput? searchInput,
  }) {
    return SearchState(
      status: status ?? this.status,
      products: products ?? this.products,
      searchInput: searchInput ?? this.searchInput,
    );
  }
}
