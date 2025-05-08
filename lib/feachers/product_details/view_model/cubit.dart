import 'dart:io';

import 'package:ecommerce_admin/core/extension/form_key_extension.dart';
import 'package:ecommerce_admin/core/helper/image_pocker_helper.dart';
import 'package:ecommerce_admin/core/models/product/product_request_model.dart';
import 'package:ecommerce_admin/core/models/product/product_update_request_model.dart';
import 'package:ecommerce_admin/feachers/product_details/repo/product_details_repo.dart';
import 'package:ecommerce_admin/feachers/product_details/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final _proudectRepo = ProductDetailsRepo();
  final String categroyId;
  final ProductModel product;
  ProductDetailsCubit({required this.categroyId, required this.product})
    : super(ProductDetailsInitial());
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? selectedImage;
  getInitialData() {
    nameController.text = product.name;
    priceController.text = product.price.toString();
    descriptionController.text = product.description;
  }

  Future<void> updateProduct() async {
    if (formKey.isValid()) {
      emit(ProductDetailsLoadingState());
      final result = await _proudectRepo.updateProduct(
        categroyId: categroyId,
        productId: product.id ?? '',
        selctedImage: selectedImage,
        product: ProductUpdateRequestModel(
          name: nameController.text,
          description: descriptionController.text,
          price: double.tryParse(priceController.text) ?? 0.0,
        ),
      );
      result.fold(
        (error) {
          emit(ProductDetailsErrorState(error: error));
        },
        (message) {
          emit(ProductDetailsUpdateSuccessState(message: message));
        },
      );
    }
  }

  Future<void> selectImage() async {
    final image = await ImagePickerHelper.getImageFromGallery();
    if (image != null) {
      selectedImage = File(image.path);
      emit(ProductDetailsUpdateImageState());
    }
  }

  Future<void> deleteProduct() async {
    emit(ProductDetailsLoadingState());
    final result = await _proudectRepo.deleteProduct(
      categroyId: categroyId,
      productId: product.id ?? '',
    );
    result.fold(
      (error) {
        emit(ProductDetailsErrorState(error: error));
      },
      (message) {
        emit(ProductDetailsDeleteSuccessState(message: message));
      },
    );
  }
}
