import 'package:flutter/material.dart';
import 'package:hishabee/dbSqflite/DBLocal.dart';
import 'package:hishabee/models/quotelocalModel.dart';
import 'package:hishabee/widgets/authorItem.dart';

class AllAuthorePage extends StatefulWidget {
  @override
  _AllAuthorePageState createState() => _AllAuthorePageState();
}

class _AllAuthorePageState extends State<AllAuthorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink, Colors.lightGreenAccent],
              begin: const FractionalOffset(0.0, 0.0),
              end:  const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text("Quotes By Authore",style: TextStyle(fontSize: 30,fontFamily: "ConcertOne",color: Colors.white),),
        centerTitle: true,
      ),
        body: FutureBuilder(
          future: DBSQfliteHelper.getAllAuthor(),
          builder: (context, AsyncSnapshot<List<QuoteSqflite>> snapshot){
            if(snapshot.hasData){
              return ListView.builder(itemBuilder: (context, index) => AuthoreItem(snapshot.data[index]),
                itemCount: snapshot.data.length,
              );
            }
            if(snapshot.hasError){
              return Center(child: Text('Faild to fetch data'),);
            }
            return Center(child: CircularProgressIndicator(),);
          },
        )
    );
  }
}
