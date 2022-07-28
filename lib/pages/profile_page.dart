import 'dart:async';

import 'package:first1/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'edit_password.dart';
import 'edit_email.dart';
import 'edit_name.dart';
import 'edit_phone.dart';
import 'package:first1/models/authentication.dart';
import '../login.dart';

import '../user/user_data.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;


    return Scaffold(
      body: Column(
        children: [
          Center(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ))),

          buildUserInfoDisplay(user.name, 'Name', EditNameFormPage()),
          buildUserInfoDisplay(user.phone, 'Phone', EditPhoneFormPage()),
          buildUserInfoDisplay(user.email, 'Email', EditEmailFormPage()),
          //buildUserInfoDisplay(user.phone, 'Phone', EditPhoneFormPage()),

          SizedBox(height: 20,),

          MaterialButton(
            minWidth: 300,
            height: 60,
            color: Colors.pink[700],
            onPressed: () {
              navigateSecondPage(EditPasswordFormPage());
            },
            shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(
                    color: Colors.black
                ),

            ),
            child: Text("Reset Password", style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,color: Colors.white,
            ),),
          ),
          SizedBox( height: 20,),
          MaterialButton(
            minWidth: 300,
            height: 60,
            color: Colors.pink[700],
            onPressed: () {
              Navigator.pop(context);
              navigateSecondPage(LoginScreen());
            },
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(
                  color: Colors.black
              ),

            ),
            child: Text("Logout", style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,color: Colors.white,
            ),),
          )
        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.black,
                      onPressed: (

                          ) {navigateSecondPage(editPage);},
                    )
                  ]))
            ],
          ));




  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
