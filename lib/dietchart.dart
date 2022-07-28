import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'global.dart' as globals;

//void main() => runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyState createState() {
    return _MyState();
  }
}

class _MyState extends State<MyApp>
{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink[700],
            title: Text("Diet Chart"),
            leading: IconButton(
              onPressed: () {
              Navigator.pop(context);
              },
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
          ),),
          body:Column(
            children:[CheckboxListTile(
            value: globals.valApple,
            onChanged: (value) {
              setState(() {
                globals.valApple = !globals.valApple;
                 //valBanana= false;
                //valMelon=false;
                 //valOrange=false;
              });
            },
            title: Text("Apple"),
            subtitle: Text("Morning at 10 AM"),
            secondary: Image.asset('assets/icon1.jpg'),
            //selected: _value,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10
            ),
          ),
              CheckboxListTile(
                value: globals.valBanana,
                onChanged: (value) {
                  setState(() {
                    //valApple = false;
                    globals.valBanana= !globals.valBanana;
                    //valMelon=false;
                    //valOrange=false;
                  });
                },
                title: Text("Banana"),
                subtitle: Text("Afternoon before Lunch"),
                secondary: Image.asset('assets/icon2.jpg',width: 50,
                  height: 100,),
                //selected: false,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: globals.valMelon,
                onChanged: (value) {
                  setState(() {
                    //valApple = false;
                    //valBanana= false;
                    globals.valMelon=!globals.valMelon;
                    //valOrange=false;
                  });
                },
                title: Text("Water Melon"),
                subtitle: Text("In the Evening"),
                secondary: Image.asset('assets/icon3.jpg'),
                //selected: val,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: globals.valOrange,
                onChanged: (value) {
                  setState(() {
                    //valApple = false;
                    //valBanana= false;
                    //valMelon=false;
                    globals.valOrange=!globals.valOrange;
                  });
                },
                title: Text("Orange"),
                subtitle: Text("In the Night"),
                secondary: Image.asset('assets/icon4.jpg'),
                //selected: false,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
        ]))
    );
  }
}