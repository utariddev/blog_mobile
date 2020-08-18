class Data {
  String article_category;
  String author_name;
  String article_read;
  String article_active;
  String article_text;
  String blog_category_name;
  String author_image;
  String article_date;
  String blog_category_image_id;
  String article_image;
  String article_title;
  String article_author;
  String image_path;
  String article_summary;
  String id;
  String article_like;

  Data.fromJsonMap(Map<String, dynamic> map)
      : article_category = map["article_category"],
        author_name = map["author_name"],
        article_read = map["article_read"],
        article_active = map["article_active"],
        article_text = map["article_text"],
        blog_category_name = map["blog_category_name"],
        author_image = map["author_image"],
        article_date = map["article_date"],
        blog_category_image_id = map["blog_category_image_id"],
        article_image = map["article_image"],
        article_title = map["article_title"],
        article_author = map["article_author"],
        image_path = map["image_path"],
        article_summary = map["article_summary"],
        id = map["id"],
        article_like = map["article_like"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['article_category'] = article_category;
    data['author_name'] = author_name;
    data['article_read'] = article_read;
    data['article_active'] = article_active;
    data['article_text'] = article_text;
    data['blog_category_name'] = blog_category_name;
    data['author_image'] = author_image;
    data['article_date'] = article_date;
    data['blog_category_image_id'] = blog_category_image_id;
    data['article_image'] = article_image;
    data['article_title'] = article_title;
    data['article_author'] = article_author;
    data['image_path'] = image_path;
    data['article_summary'] = article_summary;
    data['id'] = id;
    data['article_like'] = article_like;
    return data;
  }
}
