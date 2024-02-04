// To parse this JSON data, do
//
//     final auth = authFromJson(jsonString);

import 'dart:convert';

Auth authFromJson(String str) => Auth.fromJson(json.decode(str));

String authToJson(Auth data) => json.encode(data.toJson());

class Auth {
  bool? success;
  String? token;
  User? user;

  Auth({
    this.success,
    this.token,
    this.user,
  });

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        success: json["success"],
        token: json["token"],
        user: User.fromJson(json["user"]),
      );



  Map<String, dynamic> toJson() => {
        "success": success,
        "token": token,
        "user": user!.toJson(),
      };
}

class User {
  int? id;
  String? firstname;
  String? lastname;
  String? username;
  String? contactNumber;
  String? address;
  String? email;
  dynamic emailVerifiedAt;
  String? type;
  String? img;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.contactNumber,
    this.address,
    this.email,
    this.emailVerifiedAt,
    this.type,
    this.img,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        contactNumber: json["contact_number"],
        address: json["address"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        type: json["type"],
        img: json["img"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "contact_number": contactNumber,
        "address": address,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "type": type,
        "img": img,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
