// ignore_for_file: unrelated_type_equality_checks
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_online_sale/admin_works_pages/admin_page.dart';
import 'package:smart_online_sale/screens_pages/home_screen_page.dart';
import 'package:smart_online_sale/screens_pages/manager_page.dart';
import 'package:smart_online_sale/screens_pages/staff_page.dart';

class LoginProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  void inLoginForm(
    BuildContext context,
    final emails,
    final passwords,
    final toggleLoader,
  ) async {
    await _auth
        .signInWithEmailAndPassword(email: emails, password: passwords)
        .then((value) {
      firebaseFirestore
          .collection('allUser')
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) {
        if (value.data()!.containsValue('customer') ||
            value.data()!.containsValue('Customer')) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreenPage()),
              (Route<dynamic> route) => false);
          Fluttertoast.showToast(msg: 'Login Successfully');
        } else if (value.data()!.containsValue('admin') ||
            value.data()!.containsValue('Admin')) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const AdminPage()),
              (Route<dynamic> route) => false);
          Fluttertoast.showToast(msg: 'Login Successfully');
        } else if (value.data()!.containsValue('manager') ||
            value.data()!.containsValue('Manager')) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const ManagerPage()),
              (Route<dynamic> route) => false);
          Fluttertoast.showToast(msg: 'Login Successfully');
        } else if (value.data()!.containsValue('staff') ||
            value.data()!.containsValue('Staff')) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const StaffPage()),
              (Route<dynamic> route) => false);
          Fluttertoast.showToast(msg: 'Login Successfully');
        } else {
          return null;
        }
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }
}
