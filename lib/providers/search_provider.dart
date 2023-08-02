// ignore_for_file: prefer_final_fields
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_online_sale/modells/product_detials.dart';

class FirebaseServies {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<Map<String, dynamic>> getDataFrom() async* {
    Stream<Map<String, dynamic>> data = _db
            .collection('products')
            .snapshots()
            .map((snapShot) =>
                snapShot.docs.map((docs) => ProductDetails.fromMap(docs)))
        as Stream<Map<String, dynamic>>;
    yield* data;
  }
}

class SearchProvider extends ChangeNotifier {
  List<ProductDetails> _productDetails = [];

  List<ProductDetails> _filteredProducts = [];
  String _query = '';

  List<ProductDetails> get filteredItems => _filteredProducts;

  void setQuery(String query) {
    _query = query;
    filterProduct();
  }

  void filterProduct() {
    _filteredProducts = _productDetails
        .where((product) =>
            product.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
