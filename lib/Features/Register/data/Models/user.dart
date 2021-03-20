import 'package:messenger_app/Core/utils.dart';
import 'package:meta/meta.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class UserModel {
  final String uid;
  final String name;
  final String lastname;
  final String email;
  final String avatarurl;
  final DateTime lastMessageTime;

  const UserModel({
    this.uid,
    @required this.name,
    @required this.lastname,
    @required this.email,
    @required this.avatarurl,
    this.lastMessageTime,
  });

  UserModel copyWith({
    String uid,
    String name,
    String lastname,
    String email,
    String avatarurl,
    String lastMessageTime,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        avatarurl: avatarurl ?? this.avatarurl,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      );

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        name: json['name'],
        lastname: json['lastname'],
        email: json['email'],
        avatarurl: json['avatarurl'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'lastname': lastname,
        'email': email,
        'avatarurl': avatarurl,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
      };
}
