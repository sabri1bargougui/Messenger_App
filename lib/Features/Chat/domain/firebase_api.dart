import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger_app/Core/utils.dart';
import 'package:messenger_app/Features/Chat/data/Models/chat.dart';
import 'package:messenger_app/Features/Register/data/Models/user.dart';
import 'package:messenger_app/Features/Register/data/data.dart';

class FirebaseApi {
  static Stream<List<UserModel>> getUsers() => FirebaseFirestore.instance
      .collection('Users')
      .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(UserModel.fromJson));

  static Future uploadMessage(String uid, String message) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$uid/messages');

    final newMessage = Message(
      uid: myId,
      avatarurl: myUrlAvatar,
      name: myUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('Users');
    await refUsers.doc(uid).update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String uid) =>
      FirebaseFirestore.instance
          .collection('chats/$uid/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Future addRandomUsers(List<UserModel> users) async {
    final refUsers = FirebaseFirestore.instance.collection('Users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(uid: userDoc.id);

        await userDoc.set(newUser.toJson());
      }
    }
  }
}
