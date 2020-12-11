import 'package:flutter/material.dart';
import 'package:hishabee/Screens/quote.dart';
import 'package:hishabee/models/quotelocalModel.dart';

class AuthoreItem extends StatefulWidget {

  final QuoteSqflite model;
  AuthoreItem(this.model);

  @override
  _AuthoreItemState createState() => _AuthoreItemState();
}

class _AuthoreItemState extends State<AuthoreItem> {
  @override
  Widget build(BuildContext context) {
    return widget.model.authore != null
        ? InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>QuoteByAuthorePage(authore: widget.model.authore)));
            },
          child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink, Colors.lightGreenAccent],
                  begin: const FractionalOffset(0.0, 1.0),
                  end: const FractionalOffset(0.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  widget.model.authore,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: "ConcertOne"),
                ),
              ),
            ),
        )
        : Text("");
  }
}
