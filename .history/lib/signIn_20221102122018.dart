import 'forgot.dart';
import 'home.dart';
import 'signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late String _email, _password;
  bool _loading = false;
  late FocusNode _myFocusNode;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? _circularProgressIndicator()
        : SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 50,
                          width: 300,
                          child: TextFormField(
                            focusNode: _myFocusNode,
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
                              labelStyle: TextStyle(color: Colors.blueGrey),
                              labelText: 'Enter your email',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.blueGrey), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.white), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          )),
                      SizedBox(height: 10.0),
                      Container(
                          height: 50,
                          width: 300,
                          child: TextFormField(
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
                              labelText: 'Enter yor password',
                              labelStyle: TextStyle(color: Colors.blueGrey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.blueGrey), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.white), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            obscureText: true,
                          )),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.only(top: 15.0, left: 20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                                color: Colors.teal,
                                // fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                          height: 30,
                          width: 200,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: login,
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'New to customer portal?',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 5.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp(),
                                      fullscreenDialog: true));
                            },
                            child: Text(
                              'Register Here',
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

  Future<void> login() async {
    final _formState = _formkey.currentState;
    if (_formState!.validate()) {
      setState(() {
        _loading = true;
      });
      _formState.save();
      try {
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        final User? user = result.user;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Home(user: user!)));
      } catch (e) {
        print(e);
        setState(() {
          _loading = false;
        });
        _showDialog();
      }
    }
  }

  void _showDialog() {
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
              'Invalid Username or Password',
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
