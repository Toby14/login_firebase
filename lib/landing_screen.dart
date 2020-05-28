import 'package:flutter/material.dart';
import 'package:login_firebase/login_with_email_screen.dart';
import 'login_with_phone_number_practice.dart';


class LandingScreen extends StatefulWidget {
  static final String id = "landing_screen";
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Sign In",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
              ),),
            SizedBox(
              height: 48.0,
            ),
            RaisedButton(
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.phone_iphone,
                  color: Colors.white,),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text("Sign in with Phone Number"),
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context, LoginWithPhonePractice.id);
              },
            ),
            
            RaisedButton(
              color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.email,
                    color: Colors.white,),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text("Sign in with Email/Password"),
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context, LoginWithEmailScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
