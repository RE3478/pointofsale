import 'package:flutter/material.dart';

class SwitchListTileStockProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  var _inSale = false;
  get inSale => _inSale;

  set previousInSale(dynamic value) {
    _inSale = value;
    notifyListeners();
  }

  toggleStocksValue() {
    _inSale = !_inSale;
    notifyListeners();
  }
}

class SwitchListTilePopularProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  var _isPopular = false;
  get isPopular => _isPopular;

  set previousInPopular(dynamic value) {
    _isPopular = value;
    notifyListeners();
  }

  togglePopularValue() {
    _isPopular = !_isPopular;
    notifyListeners();
  }
}

class SwitchListTileFavouriteProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  var _isFavourite = false;
  get isFavourite => _isFavourite;

  set previousFavourite(dynamic value) {
    _isFavourite = value;
    notifyListeners();
  }

  toggleFavouriteValue() {
    _isFavourite = !_isFavourite;
    notifyListeners();
  }
}
