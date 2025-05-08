import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin/core/models/product/product_request_model.dart';
import 'package:ecommerce_admin/core/theme/app_padding.dart';
import 'package:ecommerce_admin/core/widgets/loading/custom_loading_widget.dart';
import 'package:ecommerce_admin/feachers/product_details/view/product_details_view.dart';
import 'package:ecommerce_admin/feachers/products/view_model/cubit.dart';
import 'package:ecommerce_admin/feachers/products/view_model/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'widgets/product_widget.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key, required this.categoryId});
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(categoryId)..getAllProudects(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Products'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoadingState) {
                return CustomDialogLoadingWidget();
              } else {
                final cubit = context.read<ProductsCubit>();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      cubit.products.isEmpty
                          ? Padding(
                            padding: AppPadding.allPadding,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(child: Text('No Products')),
                            ),
                          )
                          : ListView.builder(
                            itemBuilder:
                                (context, index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => BlocProvider.value(
                                              value: cubit,
                                              child: ProductDetailsView(
                                                product: cubit.products[index],
                                                categoryId: categoryId,
                                              ),
                                            ),
                                      ),
                                    );
                                  },
                                  child: _ProductsDetailsWidget(
                                    product: cubit.products[index],
                                  ),
                                ),
                            itemCount: cubit.products.length,
                          ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
