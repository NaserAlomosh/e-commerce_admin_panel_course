abstract class EditCategoryState {}

class EditCategoryInitial extends EditCategoryState {}

class EditCategoryLoadingState extends EditCategoryState {}

class EditCategorySuccessState extends EditCategoryState {}

class EditCategoryErrorState extends EditCategoryState {
  final String error;
  EditCategoryErrorState({required this.error});
}

class EditUpdateImageState extends EditCategoryState {}

class EditRequestLoadingState extends EditCategoryState {}

class EditRequestSuccessState extends EditCategoryState {}

class EditRequestErrorState extends EditCategoryState {
  final String error;

  EditRequestErrorState({required this.error});
}

class DeleteRequestLoadingState extends EditCategoryState {}

class DeleteRequestSuccessState extends EditCategoryState {}

class DeleteRequestErrorState extends EditCategoryState {
  final String error;

  DeleteRequestErrorState({required this.error});
}
