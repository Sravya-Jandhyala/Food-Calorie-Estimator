import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updateCalorie(int cal) async {
  var date = new DateTime.now().toString();
  var dateParse = DateTime.parse(date);
  var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
  await Firebase.initializeApp();
  var collection = FirebaseFirestore.instance.collection('dailyCalorie');
  var docSnapshot = await collection.doc(formattedDate).get();
  //FirebaseFirestore.instance.collection('dailyCalorie').doc(formattedDate).snapshots(),
  if (!docSnapshot.exists) {
    FirebaseFirestore.instance.collection("dailyCalorie").doc(formattedDate).set({
      'calorie' :cal
    });
  }
  else {
    Map<String, dynamic>? data = docSnapshot.data();
    var total=data?['calorie']+cal;
    FirebaseFirestore.instance.collection("dailyCalorie").doc(formattedDate).update({
      'calorie' :total
    });
  }
}

Future<void> calculateCalorie(int cal) async {
  var _recognitions;
  var _imageWidth,_imageHeight;
  var re;

  if (_recognitions == null) return ;
  if (_imageWidth == null || _imageHeight == null) return ;

  Size? screen;

  double factorX = screen!.width;
  double factorY = _imageHeight / _imageHeight * screen.width;

  var left= re["rect"]["x"] * factorX;
  var top= re["rect"]["y"] * factorY;
  var width= re["rect"]["w"] * factorX;
  var height= re["rect"]["h"] * factorY;

  var volume=left*width*height;

  var docsnapshot;
  var date = new DateTime.now().toString();
  var dateParse = DateTime.parse(date);
  var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
  await Firebase.initializeApp();
  var collection = FirebaseFirestore.instance.collection('fruitval');
  var docSnapshot = await collection.doc(formattedDate).get();
  var mass=docsnapshot*volume;
  var calper100=re["calorie"]["fruit"];
  var calories=calper100*mass;
  //FirebaseFirestore.instance.collection('dailyCalorie').doc(formattedDate).snapshots(),
  if (!docSnapshot.exists) {
    FirebaseFirestore.instance.collection("dailyCalorie").doc(formattedDate).set({
      'calorie' :cal
    });
  }
  else {
    Map<String, dynamic>? data = docSnapshot.data();
    var total=data?['calorie']+cal;
    FirebaseFirestore.instance.collection("dailyCalorie").doc(formattedDate).update({
      'calorie' :total
    });
  }
}

