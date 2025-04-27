abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {}

class HomeErrorState extends HomeStates {
  final String error;

  HomeErrorState({required this.error});
}

class HomeUpdateImageState extends HomeStates {}

class AddProductSuccessState extends HomeStates {}

class AddProductErrorsState extends HomeStates {
  final String error;

  AddProductErrorsState({required this.error});
}

class AddProductLoadingState extends HomeStates {}
