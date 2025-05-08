import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin/core/theme/app_padding.dart';
import 'package:ecommerce_admin/core/widgets/buttons/custom_button.dart';
import 'package:ecommerce_admin/core/widgets/loading/custom_loading_widget.dart';
import 'package:ecommerce_admin/core/widgets/textfieds/custom_text_field.dart';
import 'package:ecommerce_admin/core/widgets/toast_message/toast_message.dart';
import 'package:ecommerce_admin/feachers/category/view_model/cubit.dart';
import 'package:ecommerce_admin/feachers/edit_category/view_model/cubit.dart';
import 'package:ecommerce_admin/feachers/edit_category/view_model/state.dart';
import 'package:ecommerce_admin/feachers/home/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCategoryView extends StatelessWidget {
  const EditCategoryView({super.key, required this.categoryId});
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              EditCategoryCubit(categoryId: categoryId)..getCategoryById(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Edit Category'),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: AppPadding.allPadding,
          child: BlocConsumer<EditCategoryCubit, EditCategoryState>(
            listener: (context, state) => _stateHndler(context, state),
            builder: (context, state) {
              final cubit = context.read<EditCategoryCubit>();
              if (state is EditCategoryLoadingState) {
                return CustomDialogLoadingWidget();
              } else {
                return Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      CustomTextField(
                        controller: cubit.categoryNameController,
                        label: 'Name Category',
                        validator: (categoryName) {
                          if (categoryName?.isEmpty ?? true) {
                            return 'Please enter category name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          // cubit.selectImage();
                        },
                        child: Material(
                          elevation: 4,
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cubit.selectImage();
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child:
                                      cubit.selectedImage == null
                                          ? CachedNetworkImage(
                                            imageUrl:
                                                cubit.categroy?.image ?? '',
                                            progressIndicatorBuilder:
                                                (context, url, progress) =>
                                                    CustomDialogLoadingWidget(),
                                            fit: BoxFit.fitHeight,
                                          )
                                          : Image.file(cubit.selectedImage!),
                                ),
                              ),

                              if (cubit.selectedImage != null)
                                CloseButton(
                                  color: Colors.red,
                                  onPressed: () {
                                    cubit.removeImage();
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      CustomButton(
                        text: 'Edit Category',
                        onTap: () {
                          cubit.editCategory();
                        },
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        color: Colors.red,
                        text: 'Delete Category',
                        onTap: () {
                          cubit.deleteCategory();
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _stateHndler(BuildContext context, EditCategoryState state) {
    if (state is EditRequestLoadingState) {
      CustomDialogLoadingWidget.show(context);
    } else if (state is EditRequestSuccessState) {
      Navigator.pop(context);
      ToastMessage.showSuccessMessage(context, 'Category edited successfully');
      context.read<EditCategoryCubit>().getCategoryById();
      context.read<CategoryCubit>().getAllCategories();
      context.read<HomeCubit>().getAllCategories();
    } else if (state is EditRequestErrorState) {
      Navigator.pop(context);
      ToastMessage.showErrorMessage(context, state.error);
    } else if (state is DeleteRequestLoadingState) {
      CustomDialogLoadingWidget.show(context);
    } else if (state is DeleteRequestErrorState) {
      Navigator.pop(context);
      ToastMessage.showErrorMessage(context, state.error);
    } else if (state is DeleteRequestSuccessState) {
      Navigator.pop(context);
      Navigator.pop(context);
      ToastMessage.showSuccessMessage(context, 'Category deleted successfully');
      context.read<CategoryCubit>().getAllCategories();
      context.read<HomeCubit>().getAllCategories();
    }
  }
}
