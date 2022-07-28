import 'package:first1/dietchart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'global.dart' as globals;
class Section extends StatefulWidget {
  @override
  SectionState createState() => new SectionState();
}
class SectionState extends State<Section>{

  Widget build(BuildContext context){
    var res=0;
    return Container(
      height: 200,
      width: 200,
      child: Card(
        child: Column(
          children:[

            Card(
              child: ListTile(
                title: Text("Welcome User", style: TextStyle(color: Colors.white,fontSize: 40),textAlign: TextAlign.center),
              ),
              shadowColor: Colors.grey,
              elevation: 3,
              color: Colors.pink[700],
            ),

            SizedBox(height: 30,),
            const Divider(
              indent: 16,
              endIndent: 16,
            ),
            SizedBox(height: 20,),
            Text("Happy sixth month",style: TextStyle(fontSize: 25), textAlign: TextAlign.center),
            SizedBox(height: 60,),

            Row(

                children:[
                  SizedBox(width: 60,),
                  //Text("Your Progress",style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                  Text("Total Calories Consumed: ",style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                  Text("${globals.totalCalorie}",style: TextStyle(fontSize: 20), textAlign: TextAlign.center)
                  ]),
            SizedBox(height: 30,),
            Row(

            children:[
              SizedBox(width: 60,),
              //Text("Your Progress",style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
              Text("Your Progress",style: TextStyle(fontSize: 20), textAlign: TextAlign.center),

              LinearPercentIndicator(
                width: 100.0,
              lineHeight: 13.0,
              percent : (globals.totalCalorie)/2000,
              progressColor: Colors.pink[700],
            ),]),
            SizedBox(height: 30,),
            Row(

                children:[
                  SizedBox(width: 30,),
                  //Text("Your Progress",style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                  Text("Your Diet Chart Progress",style: TextStyle(fontSize: 20), textAlign: TextAlign.center),

                  LinearPercentIndicator(
                    width: 90.0,
                    lineHeight: 13.0,
                    percent : ((globals.valApple ? 1:0)+(globals.valBanana ? 1:0)+(globals.valMelon ? 1:0)+(globals.valOrange ? 1:0))/4,
                    progressColor: Colors.pink[700],
                  ),]),


            SizedBox(height: 30,),
            FlatButton(
              child: Text('Check Your Diet Chart', style: TextStyle(fontSize: 20.0),),
              color: Colors.pink[700],
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
            SizedBox(height: 30,),
            RaisedButton(
              child: new Text("Update"),
              color: Colors.pink[700],
              textColor: Colors.white,
              onPressed: (){
                setState((){
                  res=globals.totalCalorie;
                });
              },
            ),

            Text("click on the update button to refresh "),

          ]),
        elevation: 8,
        shadowColor: Colors.pink,
        margin: EdgeInsets.all(20),
      ),
    );
  }
}