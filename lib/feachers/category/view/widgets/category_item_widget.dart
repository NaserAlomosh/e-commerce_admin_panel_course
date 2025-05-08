part of '../category_view.dart';

class _CategoryItemWidget extends StatelessWidget {
  const _CategoryItemWidget({super.key, required this.category});
  final CategoryResponseModel category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsView(categoryId: category.id ?? ''),
            ),
          );
        },
        child: Material(
          elevation: 4,
          color: Colors.white,
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: category.image,
                height: 100,
                width: 100,
                progressIndicatorBuilder:
                    (context, url, progress) => CustomDialogLoadingWidget(),
              ),
              SizedBox(width: 10),
              Text(category.name),
              Spacer(),
              Builder(
                builder: (newContext) {
                  return CustomButton(
                    width: 70,
                    text: 'Edit',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BlocProvider.value(
                                value: newContext.read<HomeCubit>(),
                                child: BlocProvider.value(
                                  value: newContext.read<CategoryCubit>(),
                                  child: EditCategoryView(categoryId: category.id ?? ''),
                                ),
                              ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
