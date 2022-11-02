import 'signIn.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  bool isLogin = false;
  late User _user;
  @override
  void initState() {
    super.initState();
    currentUser().then((user) => {
          setState(() {
            isLogin = user.uid == null ? false : true;
            _user = user;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return isLogin ? Home(user: _user) : SignIn();
  }

  Future<User> currentUser() async {
    User user = FirebaseAuth.instance.currentUser!;
    return user;
  }
}
