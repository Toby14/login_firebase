import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase/profile_screen.dart';

import 'constants.dart';


class CreateScreen extends StatefulWidget {
  static final String id = "create_screen";


  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  final _auth = FirebaseAuth.instance;
  String email;
  String password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
//          backgroundColor: Colors.grey.shade800,
          appBar: AppBar(
            title: Text("MED APP"),
            backgroundColor: Colors.grey.shade700,
          ),
          body: SafeArea(
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
                    decoration: kTextFieldDecoration.copyWith(hintText: "Enter your password"),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  MaterialButton(
                    minWidth: 170.0,
                    child: Text("Register"),
                    elevation: 5.0,
                    textColor: Colors.white,
                    color: Color(0xFFFF6858),
                    onPressed: () async {
                      print("Button was clicked!");
                      try {
                      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);

                        if(newUser != null) {
                          Navigator.pushNamed(context, ProfilePage.id);
                        } else {
                          print("Can't create a new user!");
                        }
                      } catch (e) {
                        print(e.message);
                      }
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                  ),

                ],
              ),
            ),
          ));

  }
}
