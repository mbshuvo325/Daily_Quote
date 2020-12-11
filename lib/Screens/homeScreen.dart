import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hishabee/dbSqflite/DBLocal.dart';
import 'package:hishabee/models/quotelocalModel.dart';
import 'package:hishabee/provider/quoteProvider.dart';
import 'package:hishabee/widgets/customDrower.dart';
import 'package:hishabee/widgets/notification.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int share;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    initilizePreference();
    super.didChangeDependencies();
  }

  void initilizePreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      DateTime now = DateTime.now();
      String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(now);
      String formattedSavedDate = preferences.getString("date");
      if (formattedSavedDate == formattedCurrentDate) {
        share = preferences.getInt("index");
      } else {
        share = preferences.getInt("index") + 1;
        preferences.remove("index");
        preferences.setInt("index", share);
        preferences.remove("date");
        preferences.setString("date", formattedCurrentDate);
      }
    });
  }

  Quoteresponse quoteprovider;
  int index = 110;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.teal],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text("Daily Quote", style: TextStyle(
            fontSize: 30, fontFamily: "ConcertOne", color: Colors.white),),
        centerTitle: true,
        actions: [
            IconButton(icon: Icon(Icons.refresh),
                splashColor: Colors.grey,
                color: Colors.white,
                splashRadius: 10,
                iconSize: 30,
                onPressed: () async {
                  SharedPreferences preferences = await SharedPreferences
                      .getInstance();
                  setState(() {
                    int updateIndex = preferences.getInt("index") + 1;
                    preferences.remove("index");
                    preferences.setInt("index", updateIndex);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  });
                }),
        ],
      ),
      drawer: MyDrawer(),
      body: FutureBuilder(
          future: DBSQfliteHelper.getQuoteById(share),
          builder: (context, AsyncSnapshot<QuoteSqflite> snapshot) {
            if (snapshot.hasData) {
              return Container(
                //color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Center(
                        child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
                            height: MediaQuery
                                .of(context)
                                .size
                                .width * 0.5,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white,width: 2),
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [Colors.teal, Colors.teal],
                                  begin: const FractionalOffset(1.0, 0.0),
                                  end: const FractionalOffset(1.0, 1.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0,
                                        3), // changes position of shadow
                                  ),
                                ]
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, top: 5, right: 12),
                                    child: Text(snapshot.data.quotetext,
                                      style: TextStyle(color: Colors.white,
                                          fontFamily: "ConcertOne",
                                          fontSize: 25),),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0,
                                      bottom: 20),
                                  child: Text("by -${snapshot.data.authore}",
                                    style: TextStyle(color: Colors.white,
                                        fontFamily: "ConcertOne",
                                        fontSize: 20),),
                                ),
                              ],
                            )
                        )
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                             Navigator.of(context).
                          push(MaterialPageRoute(builder: (context) =>NotificitionSetPage(task: snapshot.data.quotetext)));
                          },

                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.2,
                            height: MediaQuery
                                .of(context)
                                .size
                                .width * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.pink,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Icon(Icons.notifications_active,
                              color: Colors.lightGreenAccent, size: 30,),
                          ),
                        ),
                        SizedBox(width: 20,),
                      ],
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
    );
  }
}
