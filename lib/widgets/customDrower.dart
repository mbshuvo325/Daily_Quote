import 'package:flutter/material.dart';
import 'package:hishabee/Screens/homeScreen.dart';
import 'package:hishabee/Screens/Authore.dart';
import 'package:hishabee/Screens/statistics.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20.0, bottom: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.tealAccent],
                begin: const FractionalOffset(0.0, 0.0),
                end:  const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  elevation: 8.0,
                  child: Container(
                    height: 160.0,
                    width: 160.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.asset("asset/image/quoteicon.jpg"),
                        )
                    ),
                  ),
                SizedBox(height: 10.0,),
                Text("Daily Quote",style: TextStyle(
                    color: Colors.white,fontSize: 30,fontFamily: "ConcertOne"
                ),),
              ],
            ),
          ),
          SizedBox(height: 12.0,),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.tealAccent],
                begin: const FractionalOffset(0.0, 0.0),
                end:  const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home,color: Colors.lightGreenAccent,),
                  title: Text("Home",style: TextStyle(color: Colors.white,fontFamily: "ConcertOne",fontSize: 20),),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.pink,),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                Divider(height: 10,color: Colors.white,thickness: 6.0,),
                ListTile(
                  leading: Icon(Icons.reorder,color: Colors.lightGreenAccent,),
                  title: Text("Quote By Authore",style: TextStyle(color: Colors.white,fontFamily: "ConcertOne",fontSize: 20),),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.pink,),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAuthorePage()));
                  },
                ),
                Divider(height: 10,color: Colors.white,thickness: 6.0,),
                ListTile(
                  leading: Icon(Icons.pivot_table_chart,color: Colors.lightGreenAccent,),
                  title: Text("Statistics",style: TextStyle(color: Colors.white,fontFamily: "ConcertOne",fontSize: 20),),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.pink,),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => StatisticPage()));
                  },
                ),
                Divider(height: 10,color: Colors.white,thickness: 6.0,),
                Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app,color: Colors.lightGreenAccent,),
                    title: Text("Exit",style: TextStyle(color: Colors.white,fontFamily: "ConcertOne",fontSize: 20),),
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Divider(height: 10,color: Colors.white,thickness: 6.0,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
