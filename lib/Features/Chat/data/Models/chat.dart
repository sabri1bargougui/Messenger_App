import 'package:messenger_app/Core/utils.dart';

class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  final String uid;
  final String avatarurl;
  final String name;
  final String message;
  final DateTime createdAt;

  const Message({
    this.uid,
    this.avatarurl,
    this.name,
    this.message,
    this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        uid: json['uid'],
        avatarurl: json['avatarurl'],
        name: json['name'],
        message: json['message'],
        createdAt: Utils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'avatarurl': avatarurl,
        'name': name,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
      };
}
