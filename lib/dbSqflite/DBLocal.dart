import 'package:hishabee/models/quotelocalModel.dart';
import 'package:hishabee/models/statsticModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
class DBSQfliteHelper {
 static final String CREATE_TABLE_QUOTE = '''create table $TABLE_QUOTE(
 $QUOTE_COL_ID integer primary key autoincrement,
 $QUOTE_COL_TEXT text,
 $QUOTE_COL_AUTHORE text
 )''';
  static Future<Database> open() async{
    final rootpath = await getDatabasesPath();
    final dbpath = path.join(rootpath,'quote.db');
    return openDatabase(dbpath, version: 1,onCreate: (db, version) async{
      await db.execute(CREATE_TABLE_QUOTE);
    });
  }
  static Future<int> insertQuote(QuoteSqflite quote) async{
    final db = await open();
    return db.insert(TABLE_QUOTE, quote.toMap());
  }
  static Future<QuoteSqflite> getQuoteById(int id) async {
    final db = await open();
    List<Map<String, dynamic>> mapList = await db.query(
        TABLE_QUOTE, where: '$QUOTE_COL_ID = ?', whereArgs: [id]);
    if (mapList.length > 0) {
      return QuoteSqflite.fromMap(mapList.first);
    }
  }
 static Future<List<QuoteSqflite>> getAllAuthor() async{
   final db = await open();
   List<Map<String, dynamic>> filtermapList;
   List<Map<String, dynamic>> mapList =  await db.rawQuery('select $QUOTE_COL_AUTHORE from $TABLE_QUOTE GROUP By $QUOTE_COL_AUTHORE');
   filtermapList = mapList.toSet().toList();
   return List.generate(filtermapList.length, (index) => QuoteSqflite.fromMap(filtermapList[index]));
 }
 static Future<List<QuoteSqflite>> getQuoteByName(String authore) async {
   final db = await open();
   List<Map<String, dynamic>> mapList = await db.query(TABLE_QUOTE, where: '$QUOTE_COL_AUTHORE = ?', whereArgs: [authore]);
     return List.generate(mapList.length, (index) => QuoteSqflite.fromMap(mapList[index]));
 }

 static Future<List<QuoteState>> getCountAuthorData() async{
   final db = await open();
   List<Map<String, dynamic>> mapList = await db.rawQuery('select COUNT($QUOTE_COL_TEXT) as total, $QUOTE_COL_AUTHORE from $TABLE_QUOTE GROUP By $QUOTE_COL_AUTHORE');
   return List.generate(mapList.length, (index) => QuoteState.fromMap(mapList[index]));
 }

 /*static Future<void> deleteAllData() async{
   final db = await open();
    return db.rawQuery("delete from  $TABLE_QUOTE");
 }*/

}