import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin/core/models/category/category_response_model.dart';
import 'package:ecommerce_admin/core/models/product/product_request_model.dart';
import 'package:ecommerce_admin/core/usecases/category_usecase.dart';
import 'package:ecommerce_admin/core/usecases/proudect_usecase.dart';

class HomeRepo {
  final _categoryUsecase = CategoryUsecase();
  final _proudectUsecase = ProudectUsecase();
  Future<Either<String, List<CategoryResponseModel>>> getAllCategories() async {
    return await _categoryUsecase.getAllCategories();
  }

  Future<Either<String, String>> addProduct(
    String categroyId,
    ProductModel product,
    File productImage,
  ) async {
    return await _proudectUsecase.addProudect(categroyId, product, productImage);
  }
}
