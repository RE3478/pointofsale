class CategorySelection {
  String name = "shoes";

  CategorySelection({required this.name});

  factory CategorySelection.fromMap(map) =>
      CategorySelection(name: map["name"]);

  Map<String, dynamic> toMap() {
    return {"name": name};
  }
}

class SubCategorySelection {
  String name;
  String subName;

  SubCategorySelection({required this.name, required this.subName});

  factory SubCategorySelection.fromMap(map) =>
      SubCategorySelection(name: map['name'], subName: map['subName']);

  Map<String, dynamic> toMap() {
    return {"name": name, "subName": subName};
  }
}
