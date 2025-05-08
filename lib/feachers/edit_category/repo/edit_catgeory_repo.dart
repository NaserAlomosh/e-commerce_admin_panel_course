import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin/core/models/category/category_response_model.dart';
import 'package:ecommerce_admin/core/models/category/update_category_request_model.dart';
import 'package:ecommerce_admin/core/services/upload_image_service.dart';
import 'package:ecommerce_admin/core/usecases/category_usecase.dart';

class EditCatgeoryRepo {
  CategoryUsecase categoryUsecase = CategoryUsecase();

  Future<Either<String, String>> editCategory({
    required String categoryId,
    required UpdateCategoryRequestModel updateCategoryRequestModel,
    File? newImage,
  }) async {
    if (newImage != null) {
      final image = await UploadImageService.uploadImage(newImage);
      if (image != null) {
        updateCategoryRequestModel.image = image;
      }
    }

    return await categoryUsecase.editCategroy(
      categoryId,
      updateCategoryRequestModel,
    );
  }

  Future<Either<String, CategoryResponseModel>> getCategoryById(
    String categoryId,
  ) {
    return categoryUsecase.getCategoryById(categoryId);
  }

  Future<Either<String, String>> deleteCategory(String categoryId) async {
    return await categoryUsecase.deleteCategory(categoryId);
  }
}
