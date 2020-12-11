import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hishabee/dbSqflite/DBLocal.dart';
import 'package:hishabee/models/quoteModel.dart';
import 'package:hishabee/models/quotelocalModel.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Quoteresponse extends ChangeNotifier{
  QuoteModel _quote;
  QuoteSqflite quoteSqflite;

  QuoteModel get getquoteData => _quote;

  Future fetchQuote() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final url = 'https://type.fit/api/quotes';
    var response = await Dio().get(url);
    //final response = await Http.get(url);
    if(response != null) {
      if (sharedPreferences.getBool("SyncData") == null) {
        final responseMap = json.decode(response.data);
        for (Map m in responseMap) {
          _quote = QuoteModel.fromJson(m);
          quoteSqflite = QuoteSqflite(_quote.text, _quote.author);
          DBSQfliteHelper.insertQuote(quoteSqflite).then((_) {

          });
        }
        sharedPreferences.setBool("SyncData", false);
      }
    }
    //notifyListeners();
  }
}
