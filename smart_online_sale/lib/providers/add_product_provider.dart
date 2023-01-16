import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_online_sale/modells/product_detials.dart';
import '../screens_pages/home_screen_page.dart';

class AddProductProvider with ChangeNotifier {
  final _fireBaseStore = FirebaseFirestore.instance;
  ProductDetails? productDetails;
  List<dynamic> imagesUrl = [];
  void addProductOnFireBaseStorage(
    BuildContext context,
    final idController,
    final nameController,
    final descriptionController,
    final priceController,
    final serialNoController,
    final discountPriceController,
    selectedCategory,
    List<XFile> images,
    bool inSale,
    bool isPopular,
    bool isFavorite,
    final brandNameController,
  ) async {
    // ignore: unused_local_variable

    String dowloadUrl = '';
    for (var image in images) {
      final Reference firebaseStorage =
          FirebaseStorage.instance.ref().child('prodImages').child(image.path);
      // ignore: unused_local_variable
      if (kIsWeb) {
        await firebaseStorage.putData(
          await image.readAsBytes(),
          SettableMetadata(contentType: "image/jpeg"),
        );
      }
      dowloadUrl = await firebaseStorage.getDownloadURL();
      imagesUrl.add(dowloadUrl);
    }

    /// assign data to product model
    productDetails = ProductDetails(
      category: selectedCategory,
      id: idController,
      brandName: brandNameController,
      name: nameController,
      description: descriptionController,
      price: int.parse(priceController),
      serialNo: serialNoController,
      inSale: inSale,
      imageUrl: imagesUrl,
      isPopular: isPopular,
      isFavorite: isFavorite,
      discountPrice: int.parse(discountPriceController),
    );
    // ignore: unused_local_variable

    /// upload data to firebase database
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    await _fireBaseStore
        .collection('products')
        .doc(id)
        .set(productDetails!.toMap())
        .then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreenPage()),
          (Route<dynamic> route) => false);
      Fluttertoast.showToast(msg: "Save User Successfully");
    }).catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }
}
