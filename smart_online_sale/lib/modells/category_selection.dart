class CategorySelection {
  final int cId;
  String name;

  CategorySelection({required this.cId, required this.name});

  factory CategorySelection.fromMap(map) =>
      CategorySelection(cId: map["cId"], name: map["name"]);

  Map<String, dynamic> toMap() {
    return {"cId": cId, "name": name};
  }
}

class SubCategorySelection {
  final int sCId;
  final int cId;
  String subName;

  SubCategorySelection(
      {required this.sCId, required this.cId, required this.subName});

  factory SubCategorySelection.fromMap(map) => SubCategorySelection(
      sCId: map["sCId"], cId: map["cId"], subName: map['subName']);

  Map<String, dynamic> toMap() {
    return {"sCId": sCId, "cId": cId, "subName": subName};
  }
}

class Categories {
  List<CategorySelection> categorySelections;
  List<SubCategorySelection> subCategorySelections;

  Categories(
      {required this.categorySelections, required this.subCategorySelections});
  factory Categories.fromJson(map) => Categories(
      categorySelections:
          List<CategorySelection>.from(map["categorySelections"])
              .map((e) => CategorySelection.fromMap(e))
              .toList(),
      subCategorySelections:
          List<SubCategorySelection>.from(map["subCategorySelections"])
              .map((e) => SubCategorySelection.fromMap(e))
              .toList());
  Map<String, dynamic> toMap() {
    return {
      "categorySelections":
          List<dynamic>.from(categorySelections.map((e) => e.toMap())),
      "subCategorySelections":
          List<dynamic>.from(subCategorySelections.map((e) => e.toMap())),
    };
  }
}

// class StateModel {
//   String state;
//   String alias;
//   List<String> lgas;

//   StateModel({required this.state, required this.alias, required this.lgas});

//   factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
//         state: json['state'],
//         alias: json['alias'],
//         lgas: json['lgas'],
//       );

//   Map<String, dynamic> toJson() {
//     return {
//       'state': state,
//       'alias': alias,
//       'lgas': lgas,
//     };
//   }
// }
