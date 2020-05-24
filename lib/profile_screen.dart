import 'package:flutter/material.dart';
import 'package:login_firebase/login_screen.dart';

class ProfilePage extends StatelessWidget {
  static final id = "profile_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Hello,",
              style: TextStyle(
                  fontSize: 35.0
              ),),
            Text("Congrats on connecting with Firebase Authentication! Hooray :))"),
            FlatButton(
              highlightColor: Colors.white,
              child: Text(
                "Go back to Log in screen",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
            )
          ],
        )
      ),
    );
  }
}
