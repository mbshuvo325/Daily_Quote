
class QuoteState{
  String total;
  dynamic authore;

  QuoteState(this.total, this.authore);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      "total" : total,
      "authore" : authore,
    };
    return map;
  }
  QuoteState.fromMap(Map<String, dynamic> map){
    total = map["total"].toString();
    authore = map["authore"];
  }
}