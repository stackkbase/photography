import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String _email, _password, _name;
  bool _loading = false;
  FocusNode? myFocusNode;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return _loading
        ? _circularProgressIndicator()
        : Scaffold(
            backgroundColor: Color(0xffb0B0910),
            appBar: AppBar(
              title: Text(''),
              // elevation: 0.0,
              backgroundColor: Color(0xffb0B0910),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 5.0),
                      Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 50,
                          width: 300,
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'Please Enter Name';
                              } else {
                                return null;
                              }
                            },
                            onTap: () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            onSaved: (input) => _name = input!,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(color: Colors.blueGrey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.blueGrey), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.white), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          )),
                      SizedBox(height: 10),
                      Container(
                          height: 50,
                          width: 300,
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            focusNode: myFocusNode,
                            onTap: () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'Please type a Email';
                              } else {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = RegExp(pattern as String);
                                if (!regex.hasMatch(input))
                                  return 'Enter valid Email';
                                else
                                  return null;
                              }
                            },
                            onSaved: (input) => _email = input!,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.blueGrey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.blueGrey), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.white), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              //   focusedBorder: UnderlineInputBorder(
                              //     borderSide: BorderSide(color: Colors.green)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          )),
                      SizedBox(height: 10.0),
                      Container(
                          height: 50,
                          width: 300,
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            validator: (input) {
                              if (input!.length < 6) {
                                return 'Your password needs to be atleast 6 characters';
                              } else {
                                return null;
                              }
                            },
                            onTap: () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            onSaved: (input) => _password = input!,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.blueGrey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.blueGrey), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.white), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            obscureText: true,
                          )),
                      SizedBox(height: 20.0),
                      Container(
                        height: 45.0,
                        width: 150,
                        child: Material(
                          borderRadius: BorderRadius.circular(22.0),
                          color: Colors.white,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: signup,
                            child: Center(
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already have an Account ?',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 7.0),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          );
  }

  Future<void> signup() async {
    final _formState = _formkey.currentState;
    if (_formState!.validate()) {
      setState(() {
        _loading = true;
      });
      _formState.save();
      try {
        print(_password);
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        final User user = result.user!;
        await Users(uid: user.uid).updateUserData(_name, _email);
        var collectionRef = FirebaseFirestore.instance.collection('clients');

        var doc = await collectionRef.doc(user.uid).get();
        if (!doc.exists) {
          await collectionRef.doc(user.uid).set({
            'name': _name,
            'email': user.email,
            'imageUrl':
                'https://firebasestorage.googleapis.com/v0/b/customer-portal-fac87.appspot.com/o/files%2F1115.png_300.png?alt=media&token=5ca8a4e0-cddb-445f-ae2b-04ded4c3a56c',
          });
        }
        setState(() {
          _loading = true;
        });
        _showDialogSuccess();
        Navigator.of(context).pop();
        //  Navigator.pushReplacement(
        // context, MaterialPageRoute(builder: (context) => Home()));
      } catch (e) {
        print(e.toString());
        setState(() {
          _loading = false;
        });
        _showDialog(e.toString());
      }
    }
  }

  void _showDialogSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(5, 50, 5, 10),
          child: AlertDialog(
            elevation: 24.0,
            // shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.all(Radius.circular(40.0))
            // ),
            backgroundColor: Colors.teal,
            title: null,
            content: Text(
              'Success! You can now sign in with your email',
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            actions: <Widget>[
              ElevatedButton(
                child: Text(
                  "Close",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDialog(e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(5, 50, 5, 10),
          child: AlertDialog(
            elevation: 24.0,
            backgroundColor: Colors.teal,
            content: Text(
              e,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text(
                  "Close",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _circularProgressIndicator() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
        child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(Colors.teal),
              strokeWidth: 3.0,
            )),
      ),
    );
  }
}
