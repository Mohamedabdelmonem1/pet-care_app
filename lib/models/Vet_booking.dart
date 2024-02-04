import 'dart:convert';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  List<VetBooking>? booking;

  Booking({
    this.booking,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        booking: List<VetBooking>.from(
            json["booking"].map((x) => VetBooking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "booking": List<dynamic>.from(booking!.map((x) => x.toJson())),
      };
}

class VetBooking {
  VetBooking({
    this.id,
    this.userId,
    this.doctorId,
    this.petName,
    this.date,
    this.time,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.user,
  });

  VetBooking.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    doctorId = json['doctor_id'];
    petName = json['pet_name'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userName = json['user_name'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  int? id;
  int? userId;
  int? doctorId;
  String? petName;
  String? date;
  String? time;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? userName;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['doctor_id'] = doctorId;
    map['pet_name'] = petName;
    map['date'] = date;
    map['time'] = time;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['user_name'] = userName;
    if (user != null) {
      map['user'] = user!.toJson();
    }
    return map;
  }
}

class User {
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

  User.fromJson(dynamic json) {
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
  String? img;
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
