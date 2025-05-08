import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin/core/models/product/product_request_model.dart';
import 'package:ecommerce_admin/core/usecases/proudect_usecase.dart';

class ProductsRepo {
  final _proudectUsecase = ProudectUsecase();

  Future<Either<String, List<ProductModel>>> getAllProducts(String categroyId) async {
    return _proudectUsecase.getAllProudectByCategroyId(categroyId);
  }
}
