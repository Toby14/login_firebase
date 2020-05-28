import 'package:flutter/material.dart';
import 'package:login_firebase/create_screen.dart';
import 'package:login_firebase/landing_screen.dart';
import 'package:login_firebase/login_with_email_screen.dart';
import 'package:login_firebase/login_with_phone.dart';
import 'package:login_firebase/profile_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LandingScreen.id,
      routes: {
        LoginWithEmailScreen.id: (context) => LoginWithEmailScreen(),
        CreateScreen.id: (context) => CreateScreen(),
        ProfilePage.id: (context) => ProfilePage(),
        LandingScreen.id: (context) => LandingScreen(),
        LoginWithPhone.id: (context) => LoginWithPhone(),
      },
    );
  }
}
