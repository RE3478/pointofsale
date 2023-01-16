import 'package:flutter/material.dart';
import 'package:smart_online_sale/modells/category_selection.dart';

class CategoryProviderForDropDown with ChangeNotifier {
  // ignore: prefer_typing_uninitialized_variables
  CategorySelection? _selectedCategory;
  // SubCategorySelection? _subCategorySelection;

  // ignore: prefer_final_fields
  List<DropdownMenuItem<CategorySelection>> _listOfCategory = [
    DropdownMenuItem(
        value: CategorySelection(name: 'Shoes'), child: const Text('Shoes')),
    DropdownMenuItem(
        value: CategorySelection(name: 'Clothes'),
        child: const Text('Clothes')),
    DropdownMenuItem(
        value: CategorySelection(name: 'Gadgets'),
        child: const Text('Gadgets')),
    DropdownMenuItem(
        value: CategorySelection(name: 'Electronics'),
        child: const Text('Electronics')),
    DropdownMenuItem(
        value: CategorySelection(
          name: 'Grocery',
        ),
        child: const Text('Grocery')),
    DropdownMenuItem(
        value: CategorySelection(name: 'Cosmetics'),
        child: const Text('Cosmetics'))
  ];
  // ignore: prefer_final_fields
  // List<DropdownMenuItem<SubCategorySelection>> _listofSubCategory = [
  //   DropdownMenuItem(
  //       value: SubCategorySelection(name: 'Shoes', subName: 'Men'),
  //       child: const Text('Men')),
  //   DropdownMenuItem(
  //       value: SubCategorySelection(name: 'Shoes', subName: 'Women'),
  //       child: const Text('Women')),
  //   DropdownMenuItem(
  //       value: SubCategorySelection(name: 'Shoes', subName: 'Child'),
  //       child: const Text('Child')),
  //   DropdownMenuItem(
  //       value: SubCategorySelection(name: 'Clothes', subName: 'Men'),
  //       child: const Text('Men')),
  //   DropdownMenuItem(
  //       value: SubCategorySelection(name: 'Clothes', subName: 'Women'),
  //       child: const Text('Women')),
  //   DropdownMenuItem(
  //       value: SubCategorySelection(name: 'Clothes', subName: 'Child'),
  //       child: const Text('Child')),
  // ];

  get selectedCategory => _selectedCategory;
  // get subCategorySelection => _subCategorySelection;
  get listOfCategory => _listOfCategory;
  // get listofSubCategory => _listofSubCategory;

  set onChangeDropValue(dynamic oldValue) {
    _selectedCategory!.name = oldValue;
    notifyListeners();
  }

  void onChangeValue(CategorySelection? value) {
    _selectedCategory = value!;
    notifyListeners();
  }
}
