class ProductUpdateRequestModel {
  final String name;
  final String description;
  final double price;
  String? image;

  ProductUpdateRequestModel({
    required this.name,
    required this.description,
    required this.price,
    this.image,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'price': price,
    'image': image,
  };
}
