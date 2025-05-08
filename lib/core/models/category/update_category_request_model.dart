class UpdateCategoryRequestModel {
  final String name;
  String image;

  UpdateCategoryRequestModel({required this.name, required this.image});

  Map<String, dynamic> toJson() {
    return {'name': name, 'image': image};
  }
}
