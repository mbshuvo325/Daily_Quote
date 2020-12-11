
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hishabee/Screens/homeScreen.dart';
import 'package:intl/intl.dart';

class NotificitionSetPage extends StatefulWidget {
  String task;

  NotificitionSetPage({Key key, this.task}) : super(key: key);

  @override
  _NotificitionSetPageState createState() =>
      _NotificitionSetPageState(task: task);
}

class _NotificitionSetPageState extends State<NotificitionSetPage> {
  FlutterLocalNotificationsPlugin fltrNotification;

  //String _selectedParam;
  String task;
  int val;

  _NotificitionSetPageState({this.task});

  int differenceOfDay;
  int differenceOfHoure;
  int differenceOfMinute;

  @override
  void initState() {
    super.initState();
    var androidInitilize = AndroidInitializationSettings('app_icon');
    var iOSinitilize = IOSInitializationSettings();
    var initilizationsSettings =
        InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var androidDetails = AndroidNotificationDetails(
      "Channel ID",
      "MB Shuvo",
      "This is my Code",
      importance: Importance.max,
      playSound: true,
      //sound: RawResourceAndroidNotificationSound("notify"),
    );
    var iSODetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iSODetails);

    var scheduledTime = DateTime.now().add(Duration(
        days: differenceOfDay,
        hours: differenceOfHoure,
        minutes: differenceOfMinute));

    fltrNotification.schedule(
        1, "Quote of the Day", task, scheduledTime, generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                "Select Date And Time For Reminder",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "ConcertOne",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Center(
                      child: Text(
                    "Select",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "ConcertOne",
                        fontSize: 20),
                  )),
                ),
              ),
            ),
            SizedBox(height: 20,),
            differenceOfDay != null ?
            Text("Quote Will Notify After",style: TextStyle(fontSize: 20,fontFamily: "ConcertOne",color: Colors.white),) : Text(""),
            SizedBox(height: 10,),
            differenceOfDay != null ?
            Text("${differenceOfDay} Day : ${differenceOfHoure} Hours : ${differenceOfMinute} Minute",
              style: TextStyle(fontFamily: "ConcertOne",fontSize: 20,color: Colors.white),) : Text(""),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: differenceOfDay != null ? InkWell(
                onTap: () {
                  _showNotification().then((value){
                    Fluttertoast.showToast(msg: "Notification Set Successfully");
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>HomePage()));
                  });
                  //_selectDate(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.pink,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.lightGreenAccent,
                    size: 30,
                  ),
                ),
              ) : Text(""),
            ),
            SizedBox(height: 20,),
            differenceOfDay != null
                ? Text("Click the Button For Set Notification",
              style: TextStyle(fontFamily: "ConcertOne",color: Colors.white,fontSize: 20),) : Text(""),
          ],
        ),
      ),
    );
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification Clicked $payload"),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"))
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    TimeOfDay time;
    DateTime date;
    date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    String CurrentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    TimeOfDay currentTime = TimeOfDay.now();

    var format = DateFormat("yyyy-MM-dd");
    var one = format.parseStrict(CurrentDate);

    differenceOfDay = date.difference(one).inDays;

    var timeformat = DateFormat("HH:mm");
    var Ctime = timeformat.parse(currentTime.format(context));
    var ttwo = timeformat.parse(time.format(context));
    differenceOfHoure = ttwo.difference(Ctime).inHours;

    var miformat = DateFormat("HH:mm");
    var Mtime = miformat.parse(currentTime.format(context));
    var Mtwo = miformat.parse(time.format(context));
    differenceOfMinute = Mtwo.difference(Mtime).inMinutes;
    setState(() {

    });

  }
}
