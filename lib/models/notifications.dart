import 'package:flutter/material.dart';

class MyNotification {
  var id;

  var user_id;

  var notification;

  var type;

  var created_at;

  var updated_at;

  MyNotification({
    @required this.id,
    @required this.user_id,
    @required this.notification,
    @required this.type,
    @required this.created_at,
    @required this.updated_at,
  });

  factory MyNotification.fromJson(Map<String, dynamic> json) {
    return MyNotification(
      id: json["id"],
      user_id: json["user_id"],
      notification: json["notification"],
      type: json["type"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "user_id": this.user_id,
      "notification": this.notification,
      "type": this.type,
      "created_at": this.created_at,
      "updated_at": this.updated_at,
    };
  }
}
