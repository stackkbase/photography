import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String uid;
  Users({required this.uid});
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, String email) async {
    return await users.doc(this.uid).set({
      'name': name,
      'email': email,
    });
  }
}
