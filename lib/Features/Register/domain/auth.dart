import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:messenger_app/Features/Register/data/Models/user.dart';
import 'package:messenger_app/Features/Register/domain/firestore.dart';

//import 'package:messenger_app/Features/Register/data/Models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FireStoreService _fireStoreService = FireStoreService();
  final CollectionReference _usercollection =
      FirebaseFirestore.instance.collection('Users');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instanceFor(
          bucket: "gs://messengerapp-c86e5.appspot.com");

  Future signup(
    String email,
    String password,
    String name,
    String lastname,
    File image,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      var storageref = storage.ref().child(user.uid);

      var uploadtask = storageref.putFile(image);
      String avatarurl = await (await uploadtask).ref.getDownloadURL();

      _fireStoreService.createuser(
        UserModel(
          uid: user.uid,
          email: email,
          name: name,
          lastname: lastname,
          avatarurl: avatarurl,
        ),
      );
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = result.user;
      return user;
    } catch (e) {
      throw e;
    }
  }

  Stream<DocumentSnapshot> getuserinfo() async* {
    final User user = _auth.currentUser;
    yield* _usercollection.doc(user.uid).snapshots();
  }

  Future signout() async {
    await _auth.signOut();
  }
}
