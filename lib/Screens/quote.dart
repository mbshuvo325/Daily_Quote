import 'package:flutter/material.dart';
import 'package:hishabee/dbSqflite/DBLocal.dart';
import 'package:hishabee/models/quotelocalModel.dart';
import 'package:hishabee/widgets/quoteItem.dart';

class QuoteByAuthorePage extends StatefulWidget {

  String authore;
  QuoteByAuthorePage({Key key, this.authore}) : super(key : key);

  @override
  _QuoteByAuthorePageState createState() => _QuoteByAuthorePageState(authorename: authore);
}

class _QuoteByAuthorePageState extends State<QuoteByAuthorePage> {
  String authorename;

  _QuoteByAuthorePageState({this.authorename});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.tealAccent],
                begin: const FractionalOffset(0.0, 0.0),
                end:  const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: Text("Quotes By ${authorename}",style: TextStyle(fontSize: 25,fontFamily: "ConcertOne",color: Colors.white),),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: DBSQfliteHelper.getQuoteByName(authorename),
          builder: (context, AsyncSnapshot<List<QuoteSqflite>> snapshot){
            if(snapshot.hasData){
              return ListView.builder(itemBuilder: (context, index) => QuoteItem(snapshot.data[index]),
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
