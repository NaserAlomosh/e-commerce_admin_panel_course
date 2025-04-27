class ProductModel {
  final String description;
  String? id;
  final String name;
  String image;
  final double price;

  ProductModel({
    required this.description,
    this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: double.parse(json['price'].toString()),
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'image': image, 'price': price};
  }
}
