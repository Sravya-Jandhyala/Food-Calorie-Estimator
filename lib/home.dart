import 'package:first1/camera.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home1.dart';
import 'camera.dart';
import '../pages/profile_page.dart';
class HomeScreen extends StatelessWidget{
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              Container(child: Section()),
              Container(child: StaticImage()),
              Container(child: ProfilePage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: Color(0xFF3F5AA6),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.blue,
        tabs: [
          Tab(
            text: "Home",
            icon: Icon(Icons.euro_symbol),
          ),
          Tab(
            text: "Camera",
            icon: Icon(Icons.assignment),
          ),
          Tab(
            text: "Profile",
            icon: Icon(Icons.assignment),
          ),
        ],
      ),
    );
  } }