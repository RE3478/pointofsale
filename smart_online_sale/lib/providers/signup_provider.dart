import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_online_sale/modells/user_model.dart';
import 'package:smart_online_sale/screens_pages/login_page.dart';

class SignUpProvider with ChangeNotifier {
  final firebaseFirestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  void onSubmittedSignUpForm(BuildContext context, final userName,
      final userTypes, final email, final password) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      sendDataToFireBase(userName, userTypes, email, password);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false);
    }).catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }

  void sendDataToFireBase(userName, userTypes, email, password) async {
    UserModel userModel = UserModel(
        uid: _auth.currentUser!.uid,
        name: userName,
        userType: userTypes,
        email: email,
        password: password);
    await firebaseFirestore
        .collection('allUser')
        .doc(_auth.currentUser!.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account Create Successfully");
  }
}
