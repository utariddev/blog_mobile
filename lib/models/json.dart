//import 'package:utarid/models/result.dart';
//import 'package:utarid/models/data.dart';

import 'article.dart';
import 'data.dart';

class Json {
  Result result;
  List<Data> data;

  Json.fromJsonMap(Map<String, dynamic> map)
      :
//		result = Result.fromJsonMap(map["result"]),
        data = List<Data>.from(map["data"].map((it) => Data.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = result == null ? null : result.toJson();
    data['data'] = data != null ? this.data.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
