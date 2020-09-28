import 'package:intl/intl.dart';

// class Constants  {
//   static const BASE_URL = "http://blogsrvr.herokuapp.com/rest/message/";
//   static const URL_GET_CATEGORIES = BASE_URL + "getCategories";
//   static const URL_GET_ARTICLES = BASE_URL + "getArticles";
//   static const URL_GET_CONSTANT = BASE_URL + "getConstant";
//
//   static String getCurrentDateTime() {
//     return DateFormat('yyyyMMddHHmmss').format(DateTime.now());
//   }
// }

class Constants {
  static final Constants _constants = Constants._internal();

  factory Constants() {
    return _constants;
  }

  Constants._internal();

  static const BASE_URL = "http://blogsrvr.herokuapp.com/rest/message/";
  static const URL_GET_CATEGORIES = BASE_URL + "getCategories";
  static const URL_GET_ARTICLES = BASE_URL + "getArticles";
  static const URL_GET_CONSTANT = BASE_URL + "getConstant";
  static const URL_GET_ARTICLE = BASE_URL + "getArticle";
  static const URL_GET_CATEGORY_ARTICLE = BASE_URL + "getCategoryArticles";

  String getCurrentDateTime() {
    return DateFormat('yyyyMMddHHmmss').format(DateTime.now());
  }

  String getUrlForCategories() {
    return URL_GET_CATEGORIES;
  }

  String getUrlForArticles() {
    return URL_GET_ARTICLES;
  }

  String getUrlForArticle() {
    return URL_GET_ARTICLE;
  }

  String getUrlForConstants() {
    return URL_GET_CONSTANT;
  }

  String getUrlForCategoryArticles() {
    return URL_GET_CATEGORY_ARTICLE;
  }
}
