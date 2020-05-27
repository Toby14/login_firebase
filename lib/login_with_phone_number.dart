import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_firebase/profile_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  static final String id = "login_with_phone";
  @override
  _LoginWithPhoneScreenState createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  String phoneNumber;
  List<String> phoneList = [];
  final _firestore = Firestore.instance;
  final messageTextController = TextEditingController();
  bool showSpinner = false;
  bool foundPhone = false;

  @override
  void initState() {
    super.initState();
    foundPatient();
    retrieveInfoWithPhone();
  }

  void retrieveInfoWithPhone() async {
    final patients = await _firestore.collection("patients").getDocuments();

    if (patients != null) {
      String getPhone;
      for (var eachPatient in patients.documents) {
        getPhone = eachPatient.data["cell_number"];

        print("getphone = $getPhone");
        print("phoneNumber = $phoneNumber");

        if (getPhone != null) {
          phoneList.add(getPhone);
        }

      }
    }
  }

  void foundPatient() {
    if (phoneList.contains(phoneNumber)) {
      foundPhone = true;
      print("foundPhone = $foundPhone");
      print("phoneNumber is: $phoneNumber");
      Navigator.pushNamed(context, ProfilePage.id);
    }
  }

  void printList(List<String> list) {
    if (list == null){
      print("list = $list");
      return;
    }
    for (var item in list) {
      print(item);
    }
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
                  controller: messageTextController,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    phoneNumber = value;
                  },
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
                    if (foundPhone) {
                      setState(() {
                        showSpinner = true;
                      });

                      foundPatient();
                    }
                    else {
                      print("Please try again!");
                    }

                    messageTextController.clear();
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
