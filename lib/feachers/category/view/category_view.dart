import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin/core/models/category/category_response_model.dart';
import 'package:ecommerce_admin/core/theme/app_padding.dart';
import 'package:ecommerce_admin/core/widgets/buttons/custom_button.dart';
import 'package:ecommerce_admin/core/widgets/loading/custom_loading_widget.dart';
import 'package:ecommerce_admin/core/widgets/textfieds/custom_text_field.dart';
import 'package:ecommerce_admin/core/widgets/toast_message/toast_message.dart';
import 'package:ecommerce_admin/feachers/category/view_model/cubit.dart';
import 'package:ecommerce_admin/feachers/category/view_model/state.dart';
import 'package:ecommerce_admin/feachers/edit_category/view/edit_category_view.dart';
import 'package:ecommerce_admin/feachers/home/view_model/cubit.dart';
import 'package:ecommerce_admin/feachers/products/view/proudcts_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'widgets/category_item_widget.dart';

class AddCategoryView extends StatelessWidget {
  const AddCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..getAllCategories(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Category'),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        backgroundColor: Colors.white,
        body: BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state is CategoryLoadingState) {
              CustomDialogLoadingWidget.show(context);
            } else if (state is CategorySuccessState) {
              Navigator.pop(context);
              ToastMessage.showSuccessMessage(context, 'Category added successfully');
              //context.read<HomeCubit>().getAllCategories();
            } else if (state is CategorySelectImageErrorState) {
              ToastMessage.showErrorMessage(context, state.error);
            } else if (state is CategoryErrorState) {
              Navigator.pop(context);
              ToastMessage.showErrorMessage(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is GetAllCategoryLoadingState) {
              return CustomDialogLoadingWidget();
            } else if (state is GetAllCategoryErrorState) {
              return Center(child: Text(state.error));
            } else {
              final cubit = context.read<CategoryCubit>();
              return Padding(
                padding: AppPadding.allPadding,
                child: SingleChildScrollView(
                  child: Form(
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
                            cubit.selectImage();
                          },
                          child: Material(
                            elevation: 4,
                            child: Stack(
                              children: [
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(color: Colors.white),
                                  child:
                                      cubit.image != null
                                          ? Image.file(File(cubit.image!.path))
                                          : Icon(Icons.photo_camera_back_outlined),
                                ),
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
                          text: 'Add Category',
                          onTap: () {
                            cubit.addCategory();
                          },
                        ),
                        ...List.generate(cubit.categories.length, (index) {
                          return _CategoryItemWidget(category: cubit.categories[index]);
                        }),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
