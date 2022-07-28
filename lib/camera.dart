//var calories={'apple':'95','banana':'105','orange':'60','grape':'120','carrot':'','watermelon':'70'};

import 'dart:io';
import 'dart:math';
import 'global.dart' as globals;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

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
class StaticImage extends StatefulWidget {

  @override
  _StaticImageState createState() => _StaticImageState();
}

class _StaticImageState extends State<StaticImage> {
  File _image=File("C:/Users/TAJ/Desktop/flutter/first1/assets/background.png");
  var im=0;
  List _recognitions=[];
  late bool _busy;
  double _imageWidth=100.0, _imageHeight=100.0;

  final picker = ImagePicker();

  // this function loads the model
  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/ssd_mobilenet.tflite",
      labels: "assets/labels.txt",
    );
  }


  // this function detects the objects on the image
  detectObject(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path,       // required
        model: "SSDMobileNet",
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.4,       // defaults to 0.1
        numResultsPerClass: 10,// defaults to 5
        asynch: true          // defaults to true
    );
    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        _imageWidth = info.image.width.toDouble();
        _imageHeight = info.image.height.toDouble();
      });
    })));
    setState(() {
      _recognitions = recognitions as List;
    });
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     String contentText = "Content of Dialog";
    //     return StatefulBuilder(
    //       builder: (context, setState) {
    //         return AlertDialog(
    //           title: Text("Title of Dialog"),
    //           content: Text(contentText),
    //           actions: <Widget>[
    //             TextButton(
    //               onPressed: () => Navigator.pop(context),
    //               child: Text("Cancel"),
    //             ),
    //             TextButton(
    //               onPressed: () {
    //                 setState(() {
    //                   contentText = "Changed Content of Dialog";
    //                 });
    //               },
    //               child: Text("Change"),
    //             ),
    //           ],
    //         );
    //       },
    //     );
    //   },
    // );

    var calories1={'apple':52,'banana':89,'orange':47,'grape':67,'carrot':41,'watermelon':30};
    var mp=await _recognitions[0];
    var val=calories1[mp["detectedClass"]] as int;
    var res= val - Random().nextInt(10);
    globals.totalCalorie+=res;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("The detected Fruit is ${mp["detectedClass"]}"),
        content: Text('No of Calories contained is ${res}\n\nPress Ok to add them to your calorie count'),
        actions: <Widget>[
          TextButton(
            onPressed: ( ){
              updateCalorie(calories1[mp["detectedClass"]] as int);
              Navigator.pop(context, 'OK');},
            child: const Text('OK',
                style: TextStyle(color: Color(0xff7c064f), fontSize: 16.0)),
          ),
        ],
        titleTextStyle:
        const TextStyle(color: Color(0xff7c064f), fontSize: 20.0),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _busy = true;
    loadTfModel().then((val) {{
      setState(() {
        _busy = false;
      });
    }});
  }


  // display the bounding boxes over the detected objects
  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight / _imageHeight * screen.width;

    var calories={'apple':'95','banana':'105','orange':'60','grape':'120','carrot':'41','watermelon':'70'};
    //var calories1={'apple':95,'banana':105,'orange':60,'grape':120,'carrot':41,'watermelon':70};

    Color blue = Colors.blue;

    //var val=calories1[mp["detectedClass"]] as int;
    //var res= val - Random().nextInt(20);
    return _recognitions.map((re) {

      return Container(
        child: Positioned(
            left: re["rect"]["x"] * factorX,
            top: re["rect"]["y"] * factorY,
            width: re["rect"]["w"] * factorX,
            height: re["rect"]["h"] * factorY,
            child: ((re["confidenceInClass"] > 0.50) && calories.containsKey(re["detectedClass"]) )? Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: blue,
                    width: 3,
                  )
              ),
              child: Text(
                "${re["detectedClass"]}",
                style: TextStyle(
                  background: Paint()..color = blue,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ) : Container()
        ),
      );
    }).toList();
  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> stackChildren = [];

    stackChildren.add(
        Positioned(
          // using ternary operator
          child: im==0 ?
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Please Select an Image"),
              ],
            ),
          )
              : // if not null then
          Container(
              child:Image.file(_image)
          ),
        )
    );

    stackChildren.addAll(renderBoxes(size));

    if (_busy) {
      stackChildren.add(
          Center(
            child: CircularProgressIndicator(),
          )
      );
    }

    return Scaffold(

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "Fltbtn2",

            child: Icon(Icons.camera_alt),
            backgroundColor: Colors.pink[700],
            onPressed: getImageFromCamera,
          ),
          SizedBox(width: 10,),
          FloatingActionButton(
            heroTag: "Fltbtn1",
            backgroundColor: Colors.pink[700],
            child: Icon(Icons.photo),
            onPressed: getImageFromGallery,
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child:Stack(
          children: stackChildren,
        ),
      ),
    );
  }


  // gets image from camera and runs detectObject
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if(pickedFile != null) {
        _image = File(pickedFile.path);
        im=1;
      } else {
        print("No image Selected");
      }
    });
    detectObject(_image);
  }



  // gets image from gallery and runs detectObject
  Future getImageFromGallery() async {
    //var calories={'apple':'95','banana':'105','orange':'60','grape':'120','carrot':'45','watermelon':'70'};
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile != null) {
        _image = File(pickedFile.path);
        im=1;
      } else {
        print("No image Selected");
      }
    });

    detectObject(_image);

  }
}

