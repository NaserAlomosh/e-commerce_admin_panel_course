part of '../category_view.dart';

class _CategoryItemWidget extends StatelessWidget {
  const _CategoryItemWidget({super.key, required this.category});
  final CategoryResponseModel category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Material(
          elevation: 4,
          color: Colors.white,
          child: Row(
            children: [
              Image.network(category.image, height: 100, width: 100),
              SizedBox(width: 10),
              Text(category.name),
            ],
          ),
        ),
      ),
    );
  }
}
