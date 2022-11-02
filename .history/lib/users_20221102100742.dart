import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  final String uid;
  Users({this.uid});
  final CollectionReference users = Firestore.instance.collection('users');
  
  Future updateUserData(String name , String email ) async{
    return await users.document(this.uid).setData({
      'name' : name,
      'email' : email,
    });
  }
}