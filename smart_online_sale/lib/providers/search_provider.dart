// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:smart_online_sale/modells/product_detials.dart';

class SearchProvider extends ChangeNotifier {
  List<ProductDetails> _productDetails = [];

  List<ProductDetails> _filteredProducts = [];
  String _query = '';

  List<ProductDetails> get filteredItems => _filteredProducts;

  set productDetails(List<ProductDetails> value) {
    _productDetails = value;
    filterProduct();
  }

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
