class Result {
  String desc;
  String code;

  Result.fromJsonMap(Map<String, dynamic> map)
      : desc = map["desc"],
        code = map["code"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = desc;
    data['code'] = code;
    return data;
  }
}
