// To parse this JSON data, do
//
//     final subCategories = subCategoriesFromJson(jsonString);

import 'dart:convert';

SubCategories subCategoriesFromJson(String str) =>
    SubCategories.fromJson(json.decode(str));

String subCategoriesToJson(SubCategories data) => json.encode(data.toJson());

class SubCategories {
  List<SubCategory>? subCategories;

  SubCategories({
    this.subCategories,
  });

  factory SubCategories.fromJson(Map<String, dynamic> json) => SubCategories(
        subCategories: List<SubCategory>.from(
            json["subCategories"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subCategories":
            List<dynamic>.from(subCategories!.map((x) => x.toJson())),
      };
}

class SubCategory {
  int? id;
  int? categoryId;
  String? name;
  String? img;
  String? description;

  SubCategory({
    this.id,
    this.categoryId,
    this.name,
    this.img,
    this.description,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        img: json["img"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "img": img,
        "description": description,
      };
}
