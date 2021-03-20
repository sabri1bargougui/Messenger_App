import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/Features/Chat/Presentation/Screens/chat_page.dart';
import 'package:messenger_app/Features/Register/data/Models/user.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<UserModel> users;

  const ChatBodyWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User auth = FirebaseAuth.instance.currentUser;

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final user = users[index];
            if (user.uid == auth.uid) {
              return Container(height: 0);
            } else
              return Container(
                height: 75,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatPage(user: user),
                    ));
                  },
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(user.avatarurl),
                  ),
                  title: Text(user.name),
                ),
              );
          },
          itemCount: users.length,
        ),
      ),
    );
  }
}
