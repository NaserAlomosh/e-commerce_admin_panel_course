import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin/core/models/product/product_request_model.dart';
import 'package:ecommerce_admin/core/services/upload_image_service.dart';

class ProudectUsecase {
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
}
