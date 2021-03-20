import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger_app/Features/Register/data/Models/user.dart';

class FireStoreService {
  final CollectionReference _usercollection =
      FirebaseFirestore.instance.collection('Users');
  Future createuser(UserModel user) async {
    try {
      await _usercollection.doc(user.uid).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getuser(String uid) async {
    try {
      var userdata = await _usercollection.doc(uid).get();
      return UserModel.fromJson(userdata.data());
    } catch (e) {
      return e.message;
    }
  }
}
