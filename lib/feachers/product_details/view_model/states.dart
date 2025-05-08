abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoadingState extends ProductDetailsState {}

class ProductDetailsErrorState extends ProductDetailsState {
  final String error;

  ProductDetailsErrorState({required this.error});
}

class ProductDetailsUpdateSuccessState extends ProductDetailsState {
  final String message;

  ProductDetailsUpdateSuccessState({required this.message});
}

class ProductDetailsDeleteSuccessState extends ProductDetailsState {
  final String message;

  ProductDetailsDeleteSuccessState({required this.message});
}

class ProductDetailsUpdateImageState extends ProductDetailsState {}
