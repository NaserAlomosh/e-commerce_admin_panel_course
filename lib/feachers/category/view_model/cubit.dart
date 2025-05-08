import 'dart:io';

import 'package:ecommerce_admin/core/extension/form_key_extension.dart';
import 'package:ecommerce_admin/core/helper/image_pocker_helper.dart';
import 'package:ecommerce_admin/core/models/category/category_response_model.dart';
import 'package:ecommerce_admin/feachers/category/repo/category_repo.dart';
import 'package:ecommerce_admin/feachers/category/view_model/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final _addCategoryRepo = CategoryRepo();
  CategoryCubit() : super(CategoryInitialState());
  final formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  XFile? image;
  List<CategoryResponseModel> categories = [];
  Future<void> getAllCategories() async {
    emit(GetAllCategoryLoadingState());
    final result = await _addCategoryRepo.getAllCategory();
    result.fold((error) => emit(GetAllCategoryErrorState(error: error)), (
      categoriesList,
    ) {
      categories = categoriesList;
      emit(GetAllCategorySuccessState());
    });
  }

  Future<void> addCategory() async {
    if (formKey.isValid()) {
      if (_userIsNotSelectImage()) {
        return;
      }
      emit(CategoryLoadingState());
      final result = await _addCategoryRepo.addCategory(
        categoryName: categoryNameController.text,
        image: File(image?.path ?? ''),
      );
      result.fold((error) => emit(CategoryErrorState(error: error)), (_) async {
        await getAllCategories();
        emit(CategorySuccessState());
      });
    }
  }

  bool _userIsNotSelectImage() {
    if (image == null) {
      emit(CategorySelectImageErrorState(error: 'Please select an image'));
      return true;
    }
    return false;
  }

  void removeImage() {
    image = null;
    emit(CategoryUpdateImageState());
  }

  selectImage() async {
    final selectedImage = await ImagePickerHelper.getImageFromGallery();
    if (selectedImage != null) {
      image = selectedImage;
      emit(CategoryUpdateImageState());
    }
  }
}
