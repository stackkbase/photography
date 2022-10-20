import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'upload.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? uid;
  String? userEmail;
  String? name;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff263238),
      body: Container(
          width: MediaQuery.of(context).size.width,
          /* decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ), */
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Welcome to my File Management App",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
                child: SizedBox(
                    height: 30,
                    width: 230,
                    child: SignInButton(
                      Buttons.Google,
                      text: "Sign in with Google",
                      onPressed: () async {
                        bool res = await signInWithGoogle();
                        if (res) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MainPage(uid: uid, email: userEmail)),
                          );
                        }
                      },
                    ))),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Sign in with your email and upload your files securely",
              style: TextStyle(color: Colors.white70, fontSize: 15),
            )
          ])),
    );
  }

  Future<bool> signInWithGoogle() async {
    // Initialize Firebase
    User? user;

    // The `GoogleAuthProvider` can only be used while running on the web
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
          await _auth.signInWithPopup(authProvider);

      user = userCredential.user;
    } catch (e) {
      print(e);
    }

    if (user != null) {
      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;
      imageUrl = user.photoURL;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
      prefs.setString('uid', user.uid);
      prefs.setString('name', user.displayName!);
      prefs.setString('email', user.email!);
      prefs.setString('imageUrl', user.photoURL!);

      var collectionRef = FirebaseFirestore.instance.collection('client');

      var doc = await collectionRef.doc(user.uid).get();
      if (!doc.exists) {
        await collectionRef.doc(user.uid).set({
          'name': user.displayName,
          'email': user.email,
          'imageUrl': user.photoURL,
        });
      }
      return true;
    }

    return false;
  }
}
