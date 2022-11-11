import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'upload.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'signUp.dart';
import 'signIn.dart';

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
      backgroundColor: Color(0xffb0B0910),
      body: Container(
          width: MediaQuery.of(context).size.width,
          /* decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/silhoutte.jpg'),
              fit: BoxFit.cover,
            ),
          ), */
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Welcome to Surya's photography",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text(
                "Photography exhibition 2022",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 500,
              width: 200,
              child: Image.asset('assets/banner.jpeg'),
            ),
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

      var collectionRef = FirebaseFirestore.instance.collection('clients');

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
