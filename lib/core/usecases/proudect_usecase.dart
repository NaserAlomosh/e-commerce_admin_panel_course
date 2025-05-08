import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin/core/models/product/product_request_model.dart';
import 'package:ecommerce_admin/core/models/product/product_update_request_model.dart';
import 'package:ecommerce_admin/core/services/upload_image_service.dart';

class ProudectUsecase {
  Future<Either<String, List<ProductModel>>> getAllProudectByCategroyId(
    String categroyId,
  ) async {
    try {
      List<ProductModel> products = [];
      final result =
          await FirebaseFirestore.instance
              .collection('categories')
              .doc(categroyId)
              .collection('product')
              .get();
      for (var element in result.docs) {
        products.add(ProductModel.fromJson(element.data()));
      }
      return Right(products);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Something went wrong');
    }
  }

  Future<Either<String, String>> addProudect(
    String categroyId,
    ProductModel product,
    File productImage,
  ) async {
    try {
      final image = await UploadImageService.uploadImage(productImage);
      if (image != null) {
        product.image = image;
      } else {
        return Left('Something went wrong');
      }
      final productId =
          FirebaseFirestore.instance
              .collection('categories')
              .doc(categroyId)
              .collection('product')
              .doc()
              .id;
      product.id = productId;

      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categroyId)
          .collection('product')
          .doc(productId)
          .set(product.toJson());
      return Right('Product added successfully');
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Something went wrong');
    }
  }

  Future<Either<String, String>> updateProduct({
    required String categroyId,
    required String productId,
    required ProductUpdateRequestModel product,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categroyId)
          .collection('product')
          .doc(productId)
          .update(product.toJson());
      return Right('Product updated successfully');
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Something went wrong');
    }
  }

  Future<Either<String, String>> deleteProduct({
    required String categroyId,
    required String productId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categroyId)
          .collection('product')
          .doc(productId)
          .delete();
      return Right('Product deleted successfully');
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Something went wrong');
    }
  }
}
