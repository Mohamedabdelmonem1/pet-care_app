// To parse this JSON data, do
//
//     final cartItems = cartItemsFromJson(jsonString);

import 'dart:convert';

CartItems cartItemsFromJson(String str) => CartItems.fromJson(json.decode(str));

String cartItemsToJson(CartItems data) => json.encode(data.toJson());

class CartItems {
  List<CartItem>? cartItems;

  CartItems({
    this.cartItems,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) => CartItems(
        cartItems: List<CartItem>.from(
            json["cartItems"].map((x) => CartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cartItems": List<dynamic>.from(cartItems!.map((x) => x.toJson())),
      };

  fromJson(json) {}
}

class CartItem {
  int? id;
  int? userId;
  int? productId;
  int? quantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? productName;
  Product? product;
  // int myQuantity = 0;

  CartItem({
    this.id,
    this.userId,
    this.productId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.productName,
    this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        productName: json['product_name'],
        product:
            json['product'] != null ? Product.fromJson(json['product']) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        'product_name': productName,
        'product': product!.toJson(),
      };
}

class Product {
  Product({
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

  Product.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    type = json['type'];
    title = json['title'];
    price = json['price'];
    img = json['img'];
    stock = json['stock'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  var id;
  var userId;
  var categoryId;
  var type;
  var title;
  var price;
  var img;
  var stock;
  var createdAt;
  var updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['category_id'] = categoryId;
    map['type'] = type;
    map['title'] = title;
    map['price'] = price;
    map['img'] = img;
    map['stock'] = stock;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
