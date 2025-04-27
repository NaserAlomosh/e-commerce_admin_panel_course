import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin/core/models/category/category_response_model.dart';
import 'package:ecommerce_admin/core/models/category/update_category_request_model.dart';

class CategoryUsecase {
  Future<Either<String, List<CategoryResponseModel>>> getAllCategories() async {
    try {
      List<CategoryResponseModel> categories = [];
      final result = await FirebaseFirestore.instance.collection('categories').get();
      for (var element in result.docs) {
        log(element.data().toString());
        categories.add(CategoryResponseModel.formJson(element.data()));
      }
      return Right(categories);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Something went wrong');
    }
  }

  Future<Either<String, String>> updateCategroy(
    String categoryId,
    UpdateCategoryRequestModel updateCategoryRequestModel,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .update(updateCategoryRequestModel.toJson());
      return const Right('Category updated successfully');
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Something went wrong');
    }
  }

  Future<Either<String, String>> deleteCategory(String categoryId) async {
    try {
      await FirebaseFirestore.instance.collection('categories').doc(categoryId).delete();
      return Right('Category deleted successfully');
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Something went wrong');
    }
  }
}
