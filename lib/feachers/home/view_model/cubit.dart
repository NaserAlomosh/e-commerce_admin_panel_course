import 'dart:io';

import 'package:ecommerce_admin/core/extension/form_key_extension.dart';
import 'package:ecommerce_admin/core/helper/image_pocker_helper.dart';
import 'package:ecommerce_admin/core/models/category/category_response_model.dart';
import 'package:ecommerce_admin/core/models/product/product_request_model.dart';
import 'package:ecommerce_admin/core/widgets/toast_message/toast_message.dart';
import 'package:ecommerce_admin/feachers/home/repo/home_repo.dart';
import 'package:ecommerce_admin/feachers/home/view_model/states.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeCubit extends Cubit<HomeStates> {
  final _homeRepo = HomeRepo();
  HomeCubit() : super(HomeInitialState());
  List<CategoryResponseModel> categories = [];
  XFile? image;
  final formKey = GlobalKey<FormState>();
  final categoryIdController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  Future<void> getAllCategories() async {
    final result = await _homeRepo.getAllCategories();
    result.fold((error) => emit(HomeErrorState(error: error)), (categories) {
      this.categories = categories;
      emit(HomeSuccessState());
    });
  }

  Future<void> selectProudectImage() async {
    final selectedImage = await ImagePickerHelper.getImageFromGallery();
    if (selectedImage != null) {
      image = selectedImage;
      emit(HomeUpdateImageState());
    }
  }

  void deleteImage() {
    image = null;
    emit(HomeUpdateImageState());
  }

  void addProduct(BuildContext context) {
    if (_checkedCategoryIsSelected(context)) {
      if (_checkImageIsSelected(context)) {
        if (formKey.isValid()) {
          _addProudectRequest();
        }
      }
    }
  }

  Future<void> _addProudectRequest() async {
    emit(AddProductLoadingState());
    final result = await _homeRepo.addProduct(
      categoryIdController.text,
      ProductModel(
        description: descriptionController.text,
        name: nameController.text,
        image: image?.path ?? '',
        price: double.parse(priceController.text),
      ),
      File(image?.path ?? ''),
    );
    result.fold(
      (error) => emit(AddProductErrorsState(error: error)),
      (_) => emit(AddProductSuccessState()),
    );
  }

  bool _checkImageIsSelected(BuildContext context) {
    if (image != null) {
      return true;
    } else {
      ToastMessage.showErrorMessage(context, 'Please select image');
      return false;
    }
  }

  bool _checkedCategoryIsSelected(BuildContext context) {
    if (categoryIdController.text.isNotEmpty) {
      return true;
    } else {
      ToastMessage.showErrorMessage(context, 'Please select category');
      return false;
    }
  }
}
