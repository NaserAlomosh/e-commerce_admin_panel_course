import 'dart:io';

import 'package:ecommerce_admin/core/extension/form_key_extension.dart';
import 'package:ecommerce_admin/core/helper/image_pocker_helper.dart';
import 'package:ecommerce_admin/core/models/category/category_response_model.dart';
import 'package:ecommerce_admin/core/models/category/update_category_request_model.dart';
import 'package:ecommerce_admin/feachers/edit_category/repo/edit_catgeory_repo.dart';
import 'package:ecommerce_admin/feachers/edit_category/view_model/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCategoryCubit extends Cubit<EditCategoryState> {
  final String categoryId;
  final _categoryRepo = EditCatgeoryRepo();
  EditCategoryCubit({required this.categoryId}) : super(EditCategoryInitial());
  CategoryResponseModel? categroy;
  final formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  File? selectedImage;
  void getCategoryById() async {
    emit(EditCategoryLoadingState());
    final result = await _categoryRepo.getCategoryById(categoryId);
    result.fold(
      (error) {
        emit(EditCategoryErrorState(error: error));
      },
      (categroy) {
        categoryNameController.text = categroy.name;
        this.categroy = categroy;
        emit(EditCategorySuccessState());
      },
    );
  }

  void editCategory() async {
    if (formKey.isValid()) {
      emit(EditRequestLoadingState());
      final result = await _categoryRepo.editCategory(
        categoryId: categoryId,
        updateCategoryRequestModel: UpdateCategoryRequestModel(
          name: categoryNameController.text,
          image: categroy?.image ?? '',
        ),
        newImage: selectedImage,
      );
      result.fold(
        (error) {
          emit(EditRequestErrorState(error: error));
        },
        (message) {
          selectedImage = null;
          emit(EditRequestSuccessState());
        },
      );
    }
  }

  void selectImage() async {
    final image = await ImagePickerHelper.getImageFromGallery();
    if (image != null) {
      selectedImage = File(image.path);
      emit(EditUpdateImageState());
    }
  }

  void removeImage() async {
    selectedImage = null;
    emit(EditUpdateImageState());
  }

  void deleteCategory() async {
    emit(DeleteRequestLoadingState());
    final result = await _categoryRepo.deleteCategory(categoryId);
    result.fold(
      (error) {
        emit(DeleteRequestErrorState(error: error));
      },
      (message) {
        emit(DeleteRequestSuccessState());
      },
    );
  }
}
