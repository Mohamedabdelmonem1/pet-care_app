// To parse this JSON data, do
//
//     final vets = vetsFromJson(jsonString);

import 'dart:convert';

Vets vetsFromJson(String str) => Vets.fromJson(json.decode(str));

String vetsToJson(Vets data) => json.encode(data.toJson());

class Vets {
  List<Vet>? vets;

  Vets({
    this.vets,
  });

  factory Vets.fromJson(Map<String, dynamic> json) => Vets(
        vets: List<Vet>.from(json["vets"].map((x) => Vet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vets": List<dynamic>.from(vets!.map((x) => x.toJson())),
      };
}

class Vet {
  int? id;
  String? firstname;
  String? lastname;
  String? username;
  String? contactNumber;
  String? address;
  String? email;
  dynamic emailVerifiedAt;
  String? type;
  dynamic img;
  DateTime? createdAt;
  DateTime? updatedAt;

  Vet({
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

  factory Vet.fromJson(Map<String, dynamic> json) => Vet(
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
