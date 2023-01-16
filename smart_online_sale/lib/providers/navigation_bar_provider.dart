import 'package:flutter/cupertino.dart';

class NaviBottomProvider with ChangeNotifier {
  // ignore: prefer_typing_uninitialized_variables
  var _selectedIndex = 0;

  get selectedIndex => _selectedIndex;
  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
