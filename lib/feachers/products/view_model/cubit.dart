import 'package:ecommerce_admin/core/models/product/product_request_model.dart';
import 'package:ecommerce_admin/feachers/products/repo/products_repo.dart';
import 'package:ecommerce_admin/feachers/products/view_model/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final _productsRepo = ProductsRepo();
  ProductsCubit(this.categroyId) : super(ProductsInitial());
  final String categroyId;
  List<ProductModel> products = [];
  Future<void> getAllProudects() async {
    emit(ProductsLoadingState());
    final result = await _productsRepo.getAllProducts(categroyId);
    result.fold((error) => emit(ProductsErrorState(error: error)), (products) {
      this.products = products;
      emit(ProductsSuccessState());
    });
  }
}
