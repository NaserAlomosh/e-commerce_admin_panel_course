part of '../proudcts_view.dart';

class _ProductsDetailsWidget extends StatelessWidget {
  const _ProductsDetailsWidget({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.verticalPadding,
      child: SizedBox(
        height: 140,
        child: Material(
          elevation: 8,
          color: Colors.white,
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: product.image,
                height: double.infinity,
                progressIndicatorBuilder:
                    (context, url, progress) => CustomDialogLoadingWidget(),
                width: 140,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.price.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(product.description ?? '', maxLines: 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
