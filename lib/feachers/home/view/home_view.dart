import 'dart:io';

import 'package:ecommerce_admin/core/theme/app_padding.dart';
import 'package:ecommerce_admin/core/widgets/buttons/custom_button.dart';
import 'package:ecommerce_admin/core/widgets/loading/custom_loading_widget.dart';
import 'package:ecommerce_admin/core/widgets/textfieds/custom_text_field.dart';
import 'package:ecommerce_admin/core/widgets/toast_message/toast_message.dart';
import 'package:ecommerce_admin/feachers/category/view/category_view.dart';
import 'package:ecommerce_admin/feachers/home/view_model/cubit.dart';
import 'package:ecommerce_admin/feachers/home/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllCategories(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: BlocConsumer<HomeCubit, HomeStates>(
              buildWhen:
                  (_, currentState) =>
                      currentState is HomeSuccessState ||
                      currentState is HomeLoadingState ||
                      currentState is HomeUpdateImageState,
              listener: (context, state) {
                if (state is AddProductLoadingState) {
                  CustomDialogLoadingWidget.show(context);
                } else if (state is AddProductSuccessState) {
                  Navigator.pop(context);
                  ToastMessage.showSuccessMessage(context, 'Product added');
                } else if (state is AddProductErrorsState) {
                  Navigator.pop(context);
                  ToastMessage.showErrorMessage(context, state.error);
                }
              },
              builder: (context, state) {
                final cubit = context.read<HomeCubit>();
                if (state is HomeLoadingState) {
                  return const CircularProgressIndicator();
                } else {
                  return Padding(
                    padding: AppPadding.allPadding,
                    child: SingleChildScrollView(
                      child: Form(
                        key: cubit.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),
                            DropdownMenu<String>(
                              hintText: 'Select Category',
                              width: double.infinity,
                              onSelected: (value) {
                                cubit.categoryIdController.text = value ?? '';
                              },
                              dropdownMenuEntries: List.generate(
                                cubit.categories.length,
                                (index) {
                                  return DropdownMenuEntry(
                                    value: cubit.categories[index].id ?? '',
                                    label: cubit.categories[index].name,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async => cubit.selectProudectImage(),
                              child: Material(
                                elevation: 4,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child:
                                          cubit.image == null
                                              ? Icon(
                                                Icons
                                                    .photo_camera_back_outlined,
                                                size: 60,
                                              )
                                              : Image.file(
                                                File(cubit.image!.path),
                                              ),
                                    ),
                                    CloseButton(
                                      color: Colors.red,
                                      onPressed: () => cubit.deleteImage(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              label: 'Name',
                              controller: cubit.nameController,
                              validator:
                                  (p0) =>
                                      p0!.isEmpty ? 'name is required' : null,
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              label: 'Description',
                              controller: cubit.descriptionController,
                              validator:
                                  (p0) =>
                                      p0!.isEmpty
                                          ? 'description is required'
                                          : null,
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              keyboardType: TextInputType.number,
                              label: 'Price',
                              controller: cubit.priceController,
                              validator:
                                  (p0) =>
                                      p0!.isEmpty ? 'price is required' : null,
                            ),
                            SizedBox(height: 20),
                            CustomButton(
                              text: 'Add Product',
                              onTap: () {
                                cubit.addProduct(context);
                              },
                            ),
                            SizedBox(height: 20),
                            CustomButton(
                              text: 'Add New Category',
                              color: Colors.blue,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const AddCategoryView(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
