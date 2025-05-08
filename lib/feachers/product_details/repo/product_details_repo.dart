import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin/core/models/product/product_update_request_model.dart';
import 'package:ecommerce_admin/core/services/upload_image_service.dart';
import 'package:ecommerce_admin/core/usecases/proudect_usecase.dart';

class ProductDetailsRepo {
  final _proudectUsecase = ProudectUsecase();
  Future<Either<String, String>> updateProduct({
    required String categroyId,
    required String productId,
    required ProductUpdateRequestModel product,
    File? selctedImage,
  }) async {
    if (selctedImage != null) {
      product.image = await UploadImageService.uploadImage(selctedImage);
    }
    return await _proudectUsecase.updateProduct(
      categroyId: categroyId,
      productId: productId,
      product: product,
    );
  }

  Future<Either<String, String>> deleteProduct({
    required String categroyId,
    required String productId,
  }) async {
    return await _proudectUsecase.deleteProduct(
      categroyId: categroyId,
      productId: productId,
    );
  }
}
