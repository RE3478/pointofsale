import 'package:flutter/material.dart';
import 'package:smart_online_sale/modells/category_selection.dart';

class CategoryProviderForDropDown with ChangeNotifier {
  CategorySelection? _selectedCategory;
  SubCategorySelection? _subCategorySelection;

  // ignore: prefer_final_fields
  List<DropdownMenuItem<CategorySelection>> _listOfCategory = [
    DropdownMenuItem(
        value: CategorySelection(name: 'Clothes', cId: 1),
        child: const Text('Clothes')),
    DropdownMenuItem(
        value: CategorySelection(name: 'Gadgets', cId: 2),
        child: const Text('Gadgets')),
    DropdownMenuItem(
        value: CategorySelection(name: 'Grocery', cId: 3),
        child: const Text('Grocery')),
    DropdownMenuItem(
        value: CategorySelection(name: 'Electronics', cId: 4),
        child: const Text('Electronics')),
    DropdownMenuItem(
        value: CategorySelection(name: 'Shoes', cId: 5),
        child: const Text('Shoes')),
    DropdownMenuItem(
        value: CategorySelection(name: 'Cosmetics', cId: 6),
        child: const Text('Cosmetics')),
  ];

  // ignore: prefer_final_fields
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
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 21, cId: 2, subName: 'Digital Watch'),
        child: const Text('Digital Watch')),
    DropdownMenuItem(
        value:
            SubCategorySelection(sCId: 22, cId: 2, subName: 'Digital Watch2'),
        child: const Text('Digital Watch2')),
    DropdownMenuItem(
        value:
            SubCategorySelection(sCId: 23, cId: 2, subName: 'Digital Watch3'),
        child: const Text('Digital Watch3')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 31, cId: 3, subName: 'Oil'),
        child: const Text('Oil')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 32, cId: 3, subName: 'Beans'),
        child: const Text('Beans')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 33, cId: 3, subName: 'Fats'),
        child: const Text('Fats')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 34, cId: 3, subName: 'Chees'),
        child: const Text('Chees')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 35, cId: 3, subName: 'Potatos'),
        child: const Text('Potatos')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 36, cId: 3, subName: 'Dry Fruits'),
        child: const Text('Dry Fruits')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 37, cId: 3, subName: 'Avocado'),
        child: const Text('Avocado')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 38, cId: 3, subName: 'Sauce'),
        child: const Text('Sauce')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 41, cId: 4, subName: 'Digital Watch'),
        child: const Text('Digital Watch')),
    DropdownMenuItem(
        value:
            SubCategorySelection(sCId: 42, cId: 4, subName: 'Mechanical Watch'),
        child: const Text('Mechanical Watch')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 43, cId: 4, subName: 'Memory USB'),
        child: const Text('Memory USB')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 44, cId: 4, subName: 'Men Wrist'),
        child: const Text('Men Wrist')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 51, cId: 5, subName: 'Sports'),
        child: const Text('Sports')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 52, cId: 5, subName: 'Sneakers'),
        child: const Text('Sneakers')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 53, cId: 5, subName: 'Trainee'),
        child: const Text('Trainee')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 61, cId: 6, subName: 'Lotion'),
        child: const Text('Lotion')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 62, cId: 6, subName: 'CleansingMask'),
        child: const Text('CleansingMask')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 63, cId: 6, subName: 'Cleansing Oil'),
        child: const Text('Cleansing Oil')),
    DropdownMenuItem(
        value: SubCategorySelection(sCId: 64, cId: 6, subName: 'Face Wash'),
        child: const Text('Face Wash')),
  ];
  List<DropdownMenuItem<SubCategorySelection>> _filterSubValues = [];

  get selectedCategory => _selectedCategory;
  get subCategorySelection => _subCategorySelection;
  get listOfCategory => _listOfCategory;
  get listofSubCategory => _listofSubCategory;
  get filterSubValues => _filterSubValues;

  onChangeDropValue(CategorySelection? oldValue, int catId) {
    if (_listOfCategory
        .where((element) => element.value!.cId == oldValue!.cId)
        .isEmpty) {
      _listOfCategory.add(DropdownMenuItem(
          value: CategorySelection(cId: oldValue!.cId, name: oldValue.name),
          child: Text(oldValue.name)));
    }
    if (oldValue!.cId == catId) {
      _selectedCategory = oldValue;

      print(33333333);
      print(_selectedCategory!.toMap().entries);
    }

    notifyListeners();
  }

  onChangeDropSubValue(
      SubCategorySelection? oldSubValue, int catId, int subCatId) {
    if (_listofSubCategory
        .where((element) => element.value!.cId == oldSubValue!.cId)
        .isEmpty) {
      _listofSubCategory.add(DropdownMenuItem(
          value: SubCategorySelection(
              sCId: oldSubValue!.sCId,
              cId: oldSubValue.cId,
              subName: oldSubValue.subName),
          child: Text(oldSubValue.subName)));
    }
    if (oldSubValue!.cId == catId && oldSubValue.sCId == subCatId) {
      _subCategorySelection = oldSubValue;

      print(3434343434);
      print(_subCategorySelection!.toMap());
    }

    notifyListeners();
  }

  void onChangeValue(CategorySelection? value) {
    _subCategorySelection = null;
    _selectedCategory = value!;
    _filterSubValues = _listofSubCategory
        .where((element) => element.value!.cId == _selectedCategory!.cId)
        .toList();

    notifyListeners();
  }

  void onChangeSubValue(SubCategorySelection? subValue) {
    _subCategorySelection = subValue!;
    notifyListeners();
  }
}
