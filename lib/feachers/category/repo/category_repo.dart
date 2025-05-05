import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin/core/models/category/category_response_model.dart';
import 'package:ecommerce_admin/core/services/upload_image_service.dart';
import 'package:ecommerce_admin/core/usecases/category_usecase.dart';

class CategoryRepo {
  CategoryUsecase categoryUsecase = CategoryUsecase();
  Future<Either<String, String>> addCategory({
    required File image,
    required String categoryName,
  }) async {
    try {
      final imagePath = await UploadImageService.uploadImage(image);
      if (imagePath == null) {
        return Left('Error uploading image');
      } else {
        CategoryResponseModel category = CategoryResponseModel(
          name: categoryName,
          image: imagePath ?? '',
        );
        await categoryUsecase.addCategory(category: category);
        return Right('Category added successfully');
      }
    } catch (e) {
      return Left('Error adding category: $e');
    }
  }

  Future<Either<String, List<CategoryResponseModel>>> getAllCategory() async {
    try {
      final resylt = await categoryUsecase.getAllCategories();
      return resylt;
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Something went wrong');
    }
  }
}
