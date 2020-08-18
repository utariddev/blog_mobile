import 'dart:convert';

Constant constantFromJson(String str) => Constant.fromJson(json.decode(str));

String constantToJson(Constant data) => json.encode(data.toJson());

class Constant {
  Constant({
    this.result,
    this.data,
  });

  Result result;
  String data;

  factory Constant.fromJson(Map<String, dynamic> json) => Constant(
        result: Result.fromJson(json["result"]),
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "data": data,
      };
}

class Result {
  Result({
    this.desc,
    this.code,
  });

  String desc;
  String code;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        desc: json["desc"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "code": code,
      };
}
