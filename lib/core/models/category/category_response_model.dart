class CategoryResponseModel {
  final String id;
  final String name;
  final String image;

  CategoryResponseModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryResponseModel.formJson(Map<String, dynamic> json) {
    return CategoryResponseModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
