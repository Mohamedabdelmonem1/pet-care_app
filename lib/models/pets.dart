// To parse this JSON data, do
//
//     final pets = petsFromJson(jsonString);

class Pet {
  int? id;
  int? userId;
  String? name;
  String? img;
  DateTime? vaccines;
  DateTime? createdAt;
  DateTime? updatedAt;

  Pet({
    this.id,
    this.userId,
    this.name,
    this.img,
    this.vaccines,
    this.createdAt,
    this.updatedAt,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        img: json["img"],
        vaccines: DateTime.parse(json["vaccines"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "img": img,
        "vaccines":
            "${vaccines!.year.toString().padLeft(4, '0')}-${vaccines!.month.toString().padLeft(2, '0')}-${vaccines!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
