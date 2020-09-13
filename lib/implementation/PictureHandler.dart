import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PictureHandler {
  static openGallery() async {
    // File imgGallery = await ImagePicker.pickImage(source: ImageSource.gallery);
    // return imgGallery;
    var picker = ImagePicker();
    PickedFile pickedImage;
    await picker.getImage(
        source: ImageSource.gallery
    ).then((value) {
      pickedImage = value;
    });
    if(pickedImage == null) {
      return null;
    }
    return new File(pickedImage.path);
  }
}