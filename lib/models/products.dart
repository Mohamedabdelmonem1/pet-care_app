// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  List<Recommendation>? products;
  Recommendation? recommendation;

  Products({
    this.products,
    this.recommendation,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        products: List<Recommendation>.from(
            json["products"].map((x) => Recommendation.fromJson(x))),
        recommendation: Recommendation.fromJson(json["recommendation"]),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "recommendation": recommendation!.toJson(),
      };
}

class Recommendation {
  int? id;
  int? userId;
  int? categoryId;
  String? type;
  String? title;
  String? price;
  String? img;
  int? stock;
  DateTime? createdAt;
  DateTime? updatedAt;

  Recommendation({
    this.id,
    this.userId,
    this.categoryId,
    this.type,
    this.title,
    this.price,
    this.img,
    this.stock,
    this.createdAt,
    this.updatedAt,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) => Recommendation(
        id: json["id"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        type: json["type"],
        title: json["title"],
        price: json["price"],
        img: json["img"],
        stock: json["stock"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "category_id": categoryId,
        "type": type,
        "title": title,
        "price": price,
        "img": img,
        "stock": stock,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
