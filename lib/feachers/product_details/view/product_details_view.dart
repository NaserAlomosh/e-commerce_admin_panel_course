import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin/core/models/product/product_request_model.dart';
import 'package:ecommerce_admin/core/theme/app_padding.dart';
import 'package:ecommerce_admin/core/widgets/buttons/custom_button.dart';
import 'package:ecommerce_admin/core/widgets/loading/custom_loading_widget.dart';
import 'package:ecommerce_admin/core/widgets/textfieds/custom_text_field.dart';
import 'package:ecommerce_admin/core/widgets/toast_message/toast_message.dart';
import 'package:ecommerce_admin/feachers/product_details/view_model/cubit.dart';
import 'package:ecommerce_admin/feachers/product_details/view_model/states.dart';
import 'package:ecommerce_admin/feachers/products/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'widgets/product_details_widget.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    super.key,
    required this.product,
    required this.categoryId,
  });
  final ProductModel product;
  final String categoryId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ProductDetailsCubit(product: product, categroyId: categoryId)
                ..getInitialData(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Product Details'),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: AppPadding.allPadding,
          child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
            listener: (context, state) {
              if (state is ProductDetailsLoadingState) {
                CustomDialogLoadingWidget.show(context);
              } else if (state is ProductDetailsErrorState) {
                Navigator.pop(context);
                ToastMessage.showErrorMessage(context, state.error);
              } else if (state is ProductDetailsUpdateSuccessState) {
                Navigator.pop(context);
                Navigator.pop(context);
                context.read<ProductsCubit>().getAllProudects();
                ToastMessage.showSuccessMessage(context, state.message);
              } else if (state is ProductDetailsDeleteSuccessState) {
                Navigator.pop(context);
                Navigator.pop(context);
                context.read<ProductsCubit>().getAllProudects();
                ToastMessage.showSuccessMessage(context, state.message);
              }
            },
            builder: (context, state) {
              final cubit = context.read<ProductDetailsCubit>();
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _ProductsDetailsWidget(product: product),
                    CustomButton(
                      text: 'Update',
                      onTap: () {
                        cubit.updateProduct();
                      },
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      text: 'Remove',
                      onTap: () {
                        cubit.deleteProduct();
                      },
                      color: Colors.red,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
