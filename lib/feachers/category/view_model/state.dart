abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategorySuccessState extends CategoryState {}

class CategoryUpdateImageState extends CategoryState {}

class CategoryErrorState extends CategoryState {
  final String error;
  CategoryErrorState({required this.error});
}

class CategorySelectImageErrorState extends CategoryState {
  final String error;
  CategorySelectImageErrorState({required this.error});
}

class GetAllCategoryLoadingState extends CategoryState {}

class GetAllCategorySuccessState extends CategoryState {}

class GetAllCategoryErrorState extends CategoryState {
  final String error;
  GetAllCategoryErrorState({required this.error});
}
