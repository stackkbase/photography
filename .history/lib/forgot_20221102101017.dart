import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _loading = false;
  FocusNode _myFocusNode;
  @override
  Widget build(BuildContext context) {
    return _loading
        ? _circularProgressIndicator()
        : Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            focusNode: _myFocusNode,
                            onTap: () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Please type a Email';
                              } else {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = RegExp(pattern);
                                if (!regex.hasMatch(input))
                                  return 'Enter valid Email';
                                else
                                  return null;
                              }
                            },
                            onSaved: (input) => email = input,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              //   focusedBorder: UnderlineInputBorder(
                              //     borderSide: BorderSide(color: Colors.green)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 40.0),
                          Container(
                            height: 45.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(22.0),
                              shadowColor: Colors.tealAccent,
                              color: Colors.teal,
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: _sendForgotPassWordLink,
                                child: Center(
                                  child: Text(
                                    'SEND EMAIL',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                              height: 43.0,
                              color: Colors.transparent,
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black,
                                          style: BorderStyle.solid,
                                          width: 1.0),
                                      color: Colors.transparent,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Center(
                                        child: Text('Go Back',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                      )))),
                        ],
                      ))),
            ),
          );
  }

  Future<void> _sendForgotPassWordLink() async {
    final _formState = _formkey.currentState;
    if (_formState.validate()) {
      setState(() {
        _loading = true;
      });
      _formState.save();
      if ((await doesEmailAlreadyExist(email)) == false) {
        setState(() {
          _loading = false;
        });
        _showDialogErr('Email is not valid');
      } else {
        FirebaseAuth.instance
            .sendPasswordResetEmail(email: email)
            .then((result) {
          setState(() {
            _loading = false;
          });
          _showDialog();
        }).catchError((error) {
          print(error.message);
          setState(() {
            _loading = false;
          });
          _showDialogErr(error.message);
        });
      }
    }
  }

  void _showDialogErr(e) {
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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(5, 50, 5, 10),
          child: AlertDialog(
            elevation: 24.0,
            backgroundColor: Colors.teal,
            content: Text(
              'Reset Password Email has been send',
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

  Future<bool> doesEmailAlreadyExist(String _email) async {
    final QuerySnapshot result =
        await Firestore.instance.collection('users').getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    int len = result.documents.length;
    for (int i = 0; i < len; i++) {
      print(documents[i].data['email']);
      if (documents[i].data['email'] == email) {
        return true;
      }
    }
    return false;
  }
}
