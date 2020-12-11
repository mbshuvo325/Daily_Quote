final String TABLE_QUOTE = 'tbl_quote';
final String QUOTE_COL_ID = 'id';
final String QUOTE_COL_TEXT = 'quotetext';
final String QUOTE_COL_AUTHORE = 'authore';
class QuoteSqflite{
  int id;
  String quotetext;
  String authore;

  QuoteSqflite(this.quotetext, this.authore);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      QUOTE_COL_TEXT : quotetext,
      QUOTE_COL_AUTHORE : authore,
    };
    if(id != null){
      map[QUOTE_COL_ID] = id;
    }
    return map;
  }
  QuoteSqflite.fromMap(Map<String, dynamic> map){
    id = map[QUOTE_COL_ID];
    quotetext = map[QUOTE_COL_TEXT];
    authore = map[QUOTE_COL_AUTHORE];
  }
}