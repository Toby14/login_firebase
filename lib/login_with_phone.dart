import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/profile_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginWithPhone extends StatefulWidget {
  static final String id = "login_with_phone";
  @override
  _LoginWithPhoneState createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _loggedInUser;
  final _codeController = TextEditingController();
  final _phoneController = TextEditingController();
  bool showSpinner = false;
  bool foundPhone = false;

//  @override
//  void dispose(){
//    _phoneController.dispose();
//    super.dispose();
//  }

  // codeSent callback will be executed first
  Future<bool> loginUser(String phone) async {
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          AuthResult result = await _auth.signInWithCredential(credential);
          // To dismiss the codeSent's alertDialog then use
          Navigator.of(context).pop();

          // This callback only gets called when the verification completed
          // Getting the user from Firebase using phone number
          _loggedInUser = result.user;

          // Passing this user to the Profile screen
          if (_loggedInUser != null) {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          user: _loggedInUser,
                        )));
          } else {
            print("User doesn't exist!");
          }
        },
        verificationFailed: (AuthException exception) {
          print(exception.message);
        },

        // Manually ask the user to input the code that was sent to their phone number
        codeSent: (String verificationID, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Enter the code"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      )
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.redAccent,
                      onPressed: () async {
                        final code = _codeController.text.trim();

                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationID, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        _loggedInUser = result.user;

                        if (_loggedInUser != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                        user: _loggedInUser,
                                      )));
                        } else {
                          print("User doesn't exist!");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Enter your mobile number",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextField(
                  controller: _phoneController,
                  textAlign: TextAlign.center,
//                  onChanged: (value) {
//                    phoneNumber = value;
//                  },
                  decoration: InputDecoration(
                    hintText: 'Ex: +14072221111',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.blueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Tip: Login to retrieve your information, and you wil be redirecting to Profile screen",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50.0,
                ),
                MaterialButton(
                  minWidth: 170.0,
                  elevation: 5.0,
                  child: Text("Log in"),
                  onPressed: () {

                      setState(() {
                        showSpinner = true;
                      });
                      final phoneNumber = _phoneController.text.trim();

                      loginUser(phoneNumber);

//                    _phoneController.clear();

                    showSpinner = false;
                  },
                  textColor: Colors.white,
                  color: Color(0xFFFF6858),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
