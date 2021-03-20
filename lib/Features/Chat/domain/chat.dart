import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final CollectionReference _usercollection =
      FirebaseFirestore.instance.collection('Users');

  Stream<QuerySnapshot> retrieveUsers() {
    Stream<QuerySnapshot> queryUsers = _usercollection.snapshots();

    return queryUsers;
  }
}
