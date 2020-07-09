// To parse this JSON data, do
//
//     final ekrem = ekremFromJson(jsonString);

import 'dart:convert';

Kategori kategoriFromJson(String str) => Kategori.fromJson(json.decode(str));

String kategoriToJson(Kategori data) => json.encode(data.toJson());

class Kategori {
  Kategori({
    this.result,
    this.data,
  });

  Result result;
  List<Datum> data;

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
        result: Result.fromJson(json["result"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.imagePath,
    this.blogCategoryName,
    this.id,
    this.blogCategoryImageId,
  });

  String imagePath;
  String blogCategoryName;
  String id;
  String blogCategoryImageId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        imagePath: json["image_path"],
        blogCategoryName: json["blog_category_name"],
        id: json["id"],
        blogCategoryImageId: json["blog_category_image_id"],
      );

  Map<String, dynamic> toJson() => {
        "image_path": imagePath,
        "blog_category_name": blogCategoryName,
        "id": id,
        "blog_category_image_id": blogCategoryImageId,
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
