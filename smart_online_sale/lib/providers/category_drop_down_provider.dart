import 'package:flutter/material.dart';
import 'package:smart_online_sale/modells/category_selection.dart';

class CategoryProviderForDropDown with ChangeNotifier {
  // ignore: prefer_typing_uninitialized_variables
  CategorySelection? _selectedCategory;
  // SubCategorySelection? _subCategorySelection;

  // ignore: prefer_final_fields
  List<DropdownMenuItem<CategorySelection>> _listOfCategory = [
    DropdownMenuItem(
        value: CategorySelection(name: 'text1', cId: 1),
        child: const Text('text1')),
    DropdownMenuItem(
        value: CategorySelection(name: 'text2', cId: 2),
        child: const Text('text2')),
    DropdownMenuItem(
        value: CategorySelection(name: 'text3', cId: 3),
        child: const Text('text3')),
    DropdownMenuItem(
        value: CategorySelection(name: 'text4', cId: 4),
        child: const Text('text4')),
    DropdownMenuItem(
        value: CategorySelection(name: 'text5', cId: 5),
        child: const Text('text5')),
    DropdownMenuItem(
        value: CategorySelection(name: 'text6', cId: 6),
        child: const Text('text6'))
  ];
  // ignore: prefer_final_fields, unused_field
  List<DropdownMenuItem<SubCategorySelection>> _listofSubCategory = [
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 11, cId: 1, subName: 'Men'),
        child: const Text('Men')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 12, cId: 1, subName: 'Women'),
        child: const Text('Women')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 13, cId: 1, subName: 'Child'),
        child: const Text('Child')),
  ];

  get selectedCategory => _selectedCategory;
  // get subCategorySelection => _subCategorySelection;
  get listOfCategory => _listOfCategory;
  // get listofSubCategory => _listofSubCategory;

  onChangeDropValue(dynamic oldValue) {
    print(1111111111);
    print(oldValue);
    print(1111111111);
    _selectedCategory!.name = oldValue!;
    notifyListeners();
  }

  void onChangeValue(CategorySelection? value) {
    _selectedCategory = value!;
    notifyListeners();
  }

  // void onChangeSubValue(SubCategorySelection? value) {
  //   _subCategorySelection = value;
  //   notifyListeners();
  // }
}
