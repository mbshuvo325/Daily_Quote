
import 'package:flutter/material.dart';
import 'package:hishabee/dbSqflite/DBLocal.dart';
import 'package:hishabee/models/statsticModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatisticPage extends StatefulWidget {

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {


  List<charts.Series<QuoteState, String>> _seriesBarData;
  List<QuoteState> mydata;
  _generateData(mydata) {
    _seriesBarData = List<charts.Series<QuoteState, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (QuoteState quote, _) => quote.authore.toString(),
        measureFn: (QuoteState quoten, _) => int.parse(quoten.total),
        data: mydata,
        labelAccessorFn: (QuoteState row, _) => "${row.authore}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.tealAccent],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: Text("Statistics", style:TextStyle(
              fontSize: 30,fontFamily: "ConcertOne", color: Colors.white),),
          centerTitle: true,
        ),
       body: FutureBuilder(
         future: DBSQfliteHelper.getCountAuthorData(),
         builder: (context, AsyncSnapshot<List<QuoteState>> snapshot){
           if(!snapshot.hasData){
             return Center(child:CircularProgressIndicator());
           }else{
             List<QuoteState> quote = snapshot.data
                 .map((documentSnapshot) => QuoteState.fromMap(documentSnapshot.toMap()))
                 .toList();
             _generateData(quote);
             return _buildChart(context, quote);

           }
         },
       ),
    );
  }
  Widget _buildChart(BuildContext context, List<QuoteState> Quotedata) {
    mydata = Quotedata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: [
              Text(
                'Quote by Author',
                style: TextStyle(color: Colors.white,fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.PieChart(_seriesBarData,
                  animate: true,
                  animationDuration: Duration(seconds:5),
                 /* behaviors: [
                    new charts.DatumLegend(
                      horizontalFirst: false,
                      //desiredMaxRows: 0,
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.purple.shadeDefault,
                          fontFamily: 'ConcertOne',
                          fontSize: 10),
                    )
                  ],*/
                ),
              ),
              Text("Too Many Authore to Show! Authore Overflowed",style: TextStyle(fontFamily: "ConcertOne",fontSize: 15,color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
}