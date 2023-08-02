import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_online_sale/modells/user_profile.dart';
import 'package:smart_online_sale/screens_pages/home_screen_page.dart';

class SaveUserProfileProvider with ChangeNotifier {
  final _fireBaseStore = FirebaseFirestore.instance;
  void saveUserProfie(
    BuildContext context,
    final userName,
    final phoneNum,
    final postalAddress,
    Uint8List file,
  ) async {
    String dowloadUrl = '';

    // ignore: unused_local_variable
    final fileName =
        '${FirebaseAuth.instance.currentUser!.uid} ${DateTime.now().second}';
    final Reference firebaseStorage = FirebaseStorage.instance
        .ref('products')
        .child(FirebaseAuth.instance.currentUser!.uid);
    // ignore: unused_local_variable
    final UploadTask uploadTask = firebaseStorage.putData(file);
    dowloadUrl = await firebaseStorage.getDownloadURL();
    UserProfile userProfile = UserProfile(
        personalName: userName,
        phoneNo: phoneNum,
        address: postalAddress,
        image: dowloadUrl);
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    await _fireBaseStore
        .collection('usersProfile')
        .doc(id)
        .set(userProfile.toMap())
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
