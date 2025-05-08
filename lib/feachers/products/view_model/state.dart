class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsSuccessState extends ProductsState {}

class ProductsErrorState extends ProductsState {
  final String error;
  ProductsErrorState({required this.error});
}
