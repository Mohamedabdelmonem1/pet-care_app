// To parse this JSON data, do
//
//     final booking = bookingFromJson(jsonString);

import 'dart:convert';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  List<BookingElement>? booking;

  Booking({
    this.booking,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        booking: List<BookingElement>.from(
            json["booking"].map((x) => BookingElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "booking": List<dynamic>.from(booking!.map((x) => x.toJson())),
      };
}

class BookingElement {
  int? id;
  int? userId;
  int? doctorId;
  String? petName;
  DateTime? date;
  String? time;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? doctorName;
  Doctor? doctor;

  BookingElement(
      {this.id,
      this.userId,
      this.doctorId,
      this.petName,
      this.date,
      this.time,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.doctor,
      this.doctorName});

  factory BookingElement.fromJson(Map<String, dynamic> json) => BookingElement(
        id: json["id"],
        userId: json["user_id"],
        doctorId: json["doctor_id"],
        petName: json["pet_name"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        doctorName: json['doctor_name'],
        doctor: json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "doctor_id": doctorId,
        "pet_name": petName,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        'doctor_name': doctorName,
        'doctor': doctor!.toJson(),
      };
}

class Doctor {
  Doctor({
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

  Doctor.fromJson(dynamic json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    contactNumber = json['contact_number'];
    address = json['address'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    type = json['type'];
    img = json['img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
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
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['username'] = username;
    map['contact_number'] = contactNumber;
    map['address'] = address;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['type'] = type;
    map['img'] = img;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
