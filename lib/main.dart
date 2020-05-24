import 'package:flutter/material.dart';
import 'package:login_firebase/create_screen.dart';
import 'package:login_firebase/login_screen.dart';
import 'package:login_firebase/profile_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        CreateScreen.id: (context) => CreateScreen(),
        ProfilePage.id: (context) => ProfilePage(),
      },
    );
  }
}
