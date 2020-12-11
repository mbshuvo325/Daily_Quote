import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hishabee/provider/quoteProvider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homeScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  final double radius;
  final double dotRadius;
  SplashScreen({this.radius = 50.0, this.dotRadius = 10.0});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;
  AnimationController controller;

  double radius;
  double dotRadius;

  @override
  void initState() {
    super.initState();
    radius = widget.radius;
    dotRadius = widget.dotRadius;

    print(dotRadius);

    controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 3000),
        vsync: this);

    animation_rotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    animation_radius_in = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );

    animation_radius_out = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0)
          radius = widget.radius * animation_radius_in.value;
        else if (controller.value >= 0.0 && controller.value <= 0.25)
          radius = widget.radius * animation_radius_out.value;
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    controller.repeat();
    displaySplesh();
  }
  Quoteresponse quoteprovider;

  @override
  void didChangeDependencies() async{
    quoteprovider = Provider.of<Quoteresponse>(context);
    quoteprovider.fetchQuote().then((value){

    });
    setindex();
    super.didChangeDependencies();
  }

  displaySplesh() {
    Timer(Duration(seconds: 8), () async {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Text("Welcome",
                  style: TextStyle(color: Colors.teal,fontFamily: "ConcertOne",fontSize: 25),)
            ),
            SizedBox(height: 20,),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width *0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("asset/image/quoteicon.jpg",fit: BoxFit.cover,),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              width: 100.0,
              height: 100.0,
              child: new Center(
                child: new RotationTransition(

                  turns: animation_rotation,
                  child: new Container(
                    //color: Colors.limeAccent,
                    child: new Center(
                      child: Stack(
                        children: <Widget>[
                          new Transform.translate(
                            offset: Offset(0.0, 0.0),
                            child: Dot(
                              radius: radius,
                              color: Colors.black12,
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.amber,
                            ),
                            offset: Offset(
                              radius * cos(0.0),
                              radius * sin(0.0),
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.deepOrangeAccent,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 1 * pi / 4),
                              radius * sin(0.0 + 1 * pi / 4),
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.pinkAccent,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 2 * pi / 4),
                              radius * sin(0.0 + 2 * pi / 4),
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.purple,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 3 * pi / 4),
                              radius * sin(0.0 + 3 * pi / 4),
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.yellow,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 4 * pi / 4),
                              radius * sin(0.0 + 4 * pi / 4),
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.lightGreen,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 5 * pi / 4),
                              radius * sin(0.0 + 5 * pi / 4),
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.orangeAccent,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 6 * pi / 4),
                              radius * sin(0.0 + 6 * pi / 4),
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.blueAccent,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 7 * pi / 4),
                              radius * sin(0.0 + 7 * pi / 4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text("to",style: TextStyle(color: Colors.teal,fontSize: 25,fontFamily: "ConcertOne"),),
            SizedBox(height: 10,),
            Text(" 'The Daily Quote' ",style: TextStyle(color: Colors.teal,fontSize: 25,fontFamily: "ConcertOne"),)
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {

    controller.dispose();
    super.dispose();
  }
}
  setindex() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool("dataSync") == null) {
      sharedPreferences.setInt("index", 1);
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      sharedPreferences.setString("date", formattedDate);
      sharedPreferences.setBool("dataSync", false);
    }
  }
class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),

      ),
    );
  }
}