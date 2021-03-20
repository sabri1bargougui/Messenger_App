import 'package:flutter/material.dart';
import 'package:messenger_app/Features/Chat/Presentation/Widgets/message_widget.dart';
import 'package:messenger_app/Features/Chat/data/Models/chat.dart';
import 'package:messenger_app/Features/Chat/domain/firebase_api.dart';
import 'package:messenger_app/Features/Register/data/data.dart';

class MessagesWidget extends StatelessWidget {
  final String uid;

  const MessagesWidget({
    @required this.uid,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
        stream: FirebaseApi.getMessages(uid),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final messages = snapshot.data;

                return messages.isEmpty
                    ? buildText('Say Hi..')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          return MessageWidget(
                            message: message,
                            isMe: message.uid == myId,
                          );
                        },
                      );
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
