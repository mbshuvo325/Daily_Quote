import 'package:flutter/material.dart';
import 'package:hishabee/models/quotelocalModel.dart';

class QuoteItem extends StatefulWidget {

  final QuoteSqflite model;

  QuoteItem(this.model);

  @override
  _QuoteItemState createState() => _QuoteItemState();
}

class _QuoteItemState extends State<QuoteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width*0.9,
        height: MediaQuery.of(context).size.width*0.65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.teal],
            begin: const FractionalOffset(1.0, 0.0),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0,top: 5,right: 12),
                child: Text(widget.model.quotetext,
                  style: TextStyle(color: Colors.white,fontFamily: "ConcertOne",fontSize: 25),),
              ),
            ),
            SizedBox(width: 10,),
          ],
        )
    );
  }
}
