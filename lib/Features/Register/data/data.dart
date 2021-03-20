import 'package:firebase_auth/firebase_auth.dart';

User user = FirebaseAuth.instance.currentUser;

String myId = "put your id here";
String myUsername = "put your name here";
String myUrlAvatar =
    "put your profile pic link here";
/*void updateData() async {
  User user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot snap =
      await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
  myId = snap['uid'];
  myUsername = snap['name'];
  myUrlAvatar = snap['avatarurl'];
}*/
