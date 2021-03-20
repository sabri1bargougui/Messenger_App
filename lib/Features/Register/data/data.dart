import 'package:firebase_auth/firebase_auth.dart';

User user = FirebaseAuth.instance.currentUser;

String myId = "z0ZSvbfp11Wa7hDi4HqXtXnBlJl2";
String myUsername = "ahmed";
String myUrlAvatar =
    "https://firebasestorage.googleapis.com/v0/b/messengerapp-c86e5.appspot.com/o/z0ZSvbfp11Wa7hDi4HqXtXnBlJl2?alt=media&token=ad7128db-ea3e-4497-bdcf-348bfaa39c4f";
/*void updateData() async {
  User user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot snap =
      await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
  myId = snap['uid'];
  myUsername = snap['name'];
  myUrlAvatar = snap['avatarurl'];
}*/
