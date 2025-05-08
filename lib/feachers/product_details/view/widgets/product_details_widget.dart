part of '../product_details_view.dart';

class _ProductsDetailsWidget extends StatelessWidget {
  const _ProductsDetailsWidget({required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              cubit.selectImage();
            },
            child: SizedBox(
              height: 300,
              child:
                  cubit.selectedImage != null
                      ? Image.file(cubit.selectedImage!)
                      : CachedNetworkImage(
                        imageUrl: product.image,
                        width: double.infinity,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
            ),
          ),
          const SizedBox(height: 40),
          CustomTextField(
            controller: cubit.nameController,
            label: 'Name',
            validator: (p0) {
              if (p0?.isEmpty ?? true) {
                return 'Please enter name';
              }
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: cubit.descriptionController,
            label: 'Description',
            validator: (p0) {
              if (p0?.isEmpty ?? true) {
                return 'Please enter description';
              }
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: cubit.priceController,
            label: 'Price',
            keyboardType: TextInputType.number,
            validator: (p0) {
              if (p0?.isEmpty ?? true) {
                return 'Please enter price';
              }
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
