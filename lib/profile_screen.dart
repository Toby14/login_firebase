import 'package:flutter/material.dart';
import 'package:login_firebase/login_with_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  static final id = "profile_screen";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  FirebaseUser loggedInUser;
  String name;
  String address_line;
  String city;
  String postal_code;
  String country;
  String gender;



  @override
  void initState() {
    super.initState();
    getUser();
    getPatients();
  }

  void getUser() async {
    try {
      final user = await _auth.currentUser();

      if (user != null) {
        loggedInUser = user;
        print("logged in user: ${loggedInUser.email}");
      }
    } catch (e) {
      print(e);
    }
  }

  void getPatients() async {
    final patients = await _firestore.collection("patients").getDocuments();

    if (patients != null) {
      for (var getEachPatient in patients.documents){

        if (getEachPatient.documentID == "patient001") {
          print("Printing patien001");
          name = getEachPatient.data["name"];
          print(name);
          address_line = getEachPatient.data["address_line"];
          print(address_line);
          city = getEachPatient.data["city"];
          print(city);
          postal_code = getEachPatient.data["postal_code"];
          print(postal_code);
          country = getEachPatient.data["country"];
          print(country);
          gender = getEachPatient.data["gender"];
          print(gender);
          break;
        }


//          String eachPatientID = eachPatient.documentID;
//        if (eachPatientID == "patient001") {
//          patient001 = eachPatient.documentID;
//          print("printing out patient001: $patient001");
//          name = patient001.da
//          break;
//        }
//
//        print("eachPatient: $eachPatientID");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          FlatButton(
              child: Text("Log out",
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),),
          onPressed: (){
                Navigator.pop(context);
          },
          ),

        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      width: 320.0,
                      height: 320.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Name: $name"),
                            SizedBox(
                              width: 150.0,
                              height: 5.0,
                              child: Divider(
                                color: Colors.blueGrey.shade900,

                              ),
                            ),
                            Text("Address: $address_line"),
                            SizedBox(
                              width: 150.0,
                              height: 5.0,
                              child: Divider(
                                color: Colors.blueGrey.shade900,

                              ),
                            ),
                            Text("City: $city"),
                            SizedBox(
                              width: 150.0,
                              height: 5.0,
                              child: Divider(
                                color: Colors.blueGrey.shade900,

                              ),
                            ),
                            Text("Zipcode: $postal_code"),
                            SizedBox(
                              width: 150.0,
                              height: 5.0,
                              child: Divider(
                                color: Colors.blueGrey.shade900,

                              ),
                            ),
                            Text("Country: $country"),
                            SizedBox(
                              width: 150.0,
                              height: 5.0,
                              child: Divider(
                                color: Colors.blueGrey.shade900,

                              ),
                            ),
                            Text("Gender: $gender")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 30.0,
                  left: 140.0,
                  child: GestureDetector(
                    child: Container(
                      height: 130.0,
                      width: 130.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("images/tinhtran.JPG"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
