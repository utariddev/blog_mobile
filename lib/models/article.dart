// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

// String articleToJson(Article data) => json.encode(data.toJson());

class Article {
  Article({
    this.result,
    this.data,
  });

  Result result;
  List<Datum> data;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        result: Result.fromJson(json["result"]),
        // data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        data: json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) : null,
      );

// Map<String, dynamic> toJson() => {
//       "result": result.toJson(),
//       "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
}

class Datum {
  Datum({
    this.articleCategory,
    this.authorName,
    this.articleRead,
    this.articleActive,
    this.articleText,
    this.blogCategoryName,
    this.articleDate,
    this.blogCategoryImageId,
    this.articleImage,
    this.articleTitle,
    this.articleAuthor,
    this.imagePath,
    this.articleSummary,
    this.id,
    this.articleLike,
    this.authorImage,
  });

  String articleCategory;
  String authorName;
  String articleRead;
  String articleActive;
  String articleText;
  String blogCategoryName;
  DateTime articleDate;
  String blogCategoryImageId;
  String articleImage;
  String articleTitle;
  String articleAuthor;
  String imagePath;
  String articleSummary;
  String id;
  String articleLike;
  String authorImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        articleCategory: json["article_category"],
        authorName: json["author_name"],
        articleRead: json["article_read"],
        articleActive: json["article_active"],
        articleText: json["article_text"],
        blogCategoryName: json["blog_category_name"],
        articleDate: DateTime.parse(json["article_date"]),
        blogCategoryImageId: json["blog_category_image_id"],
        articleImage: json["article_image"],
        articleTitle: json["article_title"],
        articleAuthor: json["article_author"],
        imagePath: json["image_path"],
        articleSummary: json["article_summary"],
        id: json["id"],
        articleLike: json["article_like"],
        authorImage: json["author_image"],
      );

// Map<String, dynamic> toJson() => {
//       "article_category": articleCategory,
//       "author_name": authorName,
//       "article_read": articleRead,
//       "article_active": articleActive,
//       "article_text": articleText,
//       "blog_category_name": blogCategoryName,
//       "article_date": articleDate.toIso8601String(),
//       "blog_category_image_id": blogCategoryImageId,
//       "article_image": articleImage,
//       "article_title": articleTitle,
//       "article_author": articleAuthor,
//       "image_path": imagePath,
//       "article_summary": articleSummary,
//       "id": id,
//       "article_like": articleLike,
//       "author_image": authorImage
//     };
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

// Map<String, dynamic> toJson() => {
//       "desc": desc,
//       "code": code,
//     };
}
