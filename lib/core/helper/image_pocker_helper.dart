import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<XFile?> getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickMedia();
    return image;
  }
}
