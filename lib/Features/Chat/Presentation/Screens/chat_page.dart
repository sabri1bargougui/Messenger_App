import 'package:flutter/material.dart';
import 'package:messenger_app/Features/Chat/Presentation/Widgets/messages_widget.dart';
import 'package:messenger_app/Features/Chat/Presentation/Widgets/new_message_widget.dart';
import 'package:messenger_app/Features/Chat/Presentation/Widgets/profile_header_widget.dart';
import 'package:messenger_app/Features/Register/data/Models/user.dart';

class ChatPage extends StatefulWidget {
  final UserModel user;

  const ChatPage({
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: widget.user.name),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: MessagesWidget(uid: widget.user.uid),
                ),
              ),
              NewMessageWidget(uid: widget.user.uid)
            ],
          ),
        ),
      );
}
