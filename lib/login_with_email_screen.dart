import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/constants.dart';
import 'package:login_firebase/create_screen.dart';
import 'package:login_firebase/profile_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginWithEmailScreen extends StatefulWidget {
  static final id = "login_with_email";
  @override
  _LoginWithEmailScreenState createState() => _LoginWithEmailScreenState();
}

class _LoginWithEmailScreenState extends State<LoginWithEmailScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//          backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          title: Text("MED APP"),
          backgroundColor: Colors.grey.shade700,
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TypewriterAnimatedTextKit(
                    text: ['Medication App'],
                    textStyle: TextStyle(
                      fontSize: 35.0,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w900,
                    ),
                    speed: Duration(seconds: 1),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
//
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: "Enter your password"),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  MaterialButton(
                    minWidth: 170.0,
                    child: Text("Log in"),
                    elevation: 5.0,
                    textColor: Colors.white,
                    color: Color(0xFFFF6858),
                    onPressed: () async {
                      print("Button was clicked!");
                      try {
                        setState(() {
                          showSpinner = true;
                        });
                        final user = await _auth.signInWithEmailAndPassword(email: email, password: password);

                        if(user!= null) {
//                        print("printing out user.email: ${user.user.email}");
//                        print("printing out user.uid: ${user.user.uid}");

                          Navigator.pushNamed(context, ProfilePage.id);
                        } else {
                          print("Can't sign in..");
                        }
                      } catch (e) {
                        print(e.message);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                  FlatButton(
//                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    padding: EdgeInsets.only(top: 0.0),
                    highlightColor: Colors.white,
                    onPressed: () {
                      print("create an account clicked!");
                      Navigator.pushNamed(context, CreateScreen.id);
                    },
                    child: Text(
                      "Create an account?",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  }
}
