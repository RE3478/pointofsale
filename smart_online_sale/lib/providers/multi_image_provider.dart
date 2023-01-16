import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class MultiImageProvider with ChangeNotifier {
  final imagepicker = ImagePicker();
  // ignore: prefer_final_fields
  List<XFile> _images = [];
  get images => _images;

  void uploadMultiImages() async {
    final List<XFile> pickImages = await imagepicker.pickMultiImage();
    // ignore: unnecessary_null_comparison
    if (pickImages != null) {
      _images.addAll(pickImages);
    } else {
      Fluttertoast.showToast(msg: 'images not selected');
    }
    notifyListeners();
  }

  void imagesDeletion(int index) {
    // ignore: unnecessary_null_comparison
    if (index != null) {
      _images.removeAt(index);
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Already Images have been deleted");
      notifyListeners();
    }
  }
}
