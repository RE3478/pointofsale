import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_online_sale/modells/product_detials.dart';
import 'package:smart_online_sale/screens_pages/home_screen_page.dart';

class ProductUpdationProvider with ChangeNotifier {
  final _fireBaseStore = FirebaseFirestore.instance;
  ProductDetails? productDetails;
  List<dynamic> imagesUrl = [];
  void updateDataOnFirebase(
    BuildContext context,
    final idController,
    final nameController,
    final descriptionController,
    final priceController,
    final serialNoController,
    final discountPriceController,
    final categoryValue,
    List<XFile> images,
    inSale,
    isPopular,
    isFavourite,
    final brandController,
    String? proDataId,
  ) async {
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
      category: categoryValue,
      id: idController,
      brandName: brandController,
      name: nameController,
      description: descriptionController,
      price: int.parse(priceController),
      serialNo: serialNoController,
      inSale: inSale,
      imageUrl: imagesUrl,
      isPopular: isPopular,
      isFavorite: isFavourite,
      discountPrice: int.parse(discountPriceController),
    );
    // ignore: unused_local_variable

    /// upload data to firebase database
    await _fireBaseStore
        .collection('products')
        .doc(proDataId)
        .update(productDetails!.toMap())
        .then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreenPage()),
          (Route<dynamic> route) => false);
      Fluttertoast.showToast(msg: "Update User Successfully");
    }).catchError((e) {
      Fluttertoast.showToast(msg: e);
    });
  }
}
