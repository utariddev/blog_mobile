import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_test/ui/yanmenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'constants.dart';
import 'ui/detay.dart';
import 'models/constant.dart';
import 'models/kategori.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final dio = new Dio();
  Future<Kategori> futureKategori; //veri
  Future<Constant> futureConstant;
  YanMenu sayfaYan;
  Kategori kategori;
  Constant constant;

  @override
  void initState() {
    super.initState();

    futureKategori = kategoriVerileriGetir();
    futureConstant = cssVerisiGetir();
    sayfaYan = YanMenu(futureKategori);
  }

  Future<Kategori> kategoriVerileriGetir() async {
    final response = await dio.post(
      Constants.URL_GET_CATEGORIES,
      data: jsonEncode(<String, String>{"": ""}),
    );
//    debugPrint("kategoriVerileriGetir response : " + response.toString());
    var decodedJson = json.decode(response.toString());
    kategori = Kategori.fromJson(decodedJson);
    return kategori;
  }

  Future<Constant> cssVerisiGetir() async {
    final response = await dio.post(
      Constants.URL_GET_CONSTANT,
      data: jsonEncode(<String, String>{"key": "css"}),
    );
    debugPrint("cssVerisiGetir response : " + response.toString());
    var decodedJson = json.decode(response.toString());
    constant = Constant.fromJson(decodedJson);
    return constant;
  }

  Future<void> getPost() async {
    final responseBody = (await dio.get('http://jsonplaceholder.typicode.com/posts?_start=1&_limit=5'));
    debugPrint("responseBody : " + responseBody.data.toString());
  }

//  void _incrementCounter() {
//
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: sayfaYan,
        body: PagewiseSliverListExample(),
      ),
    );
  }
}

class PagewiseSliverListExample extends StatelessWidget {
//  static const int PAGE_SIZE = 1000;
  int indicator = -2;
  YanMenu sayfaYan;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr');
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: CustomScrollView(slivers: [
        SliverAppBar(
          // title: Text("UTARID"),
          leading: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
//                  Navigator.of(context)
//                    ..push(MaterialPageRoute(builder: (context) => sayfaYan,)
////articleId: articles[index]['id']  articleId: BackendService.articles[_]['id'],
//                    );
              },
              child: Icon(Icons.menu, color: Colors.grey.shade600)),
          elevation: 4,
          actionsIconTheme: IconThemeData(opacity: 0.0, color: Colors.grey),
          snap: false,
          floating: false,
          pinned: true,
          // primary: true,
          expandedHeight: 200,
          backgroundColor: Colors.white60,
          flexibleSpace: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Image.network(
                "https://i.ibb.co/Yc9vnRk/logo.png",
                fit: BoxFit.contain,
              ))
            ],
          ),
        ),
        PagewiseSliverList(
            pageSize: 3, itemBuilder: this._itemBuilder, pageFuture: (pageIndex) => BackendService.getPosts())
      ]),
    );
  }

  Widget _itemBuilder(context, PostModel entry, index) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                ..push(MaterialPageRoute(
                    builder: (context) => Detay(
                          articleId: BackendService.articles[index]['id'],
                        )
//articleId: articles[index]['id']  articleId: BackendService.articles[_]['id'],
                    ));
            },
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade50,
              elevation: 6,
              child:
                  //Text("bvcfdxfcgvhb:" + index.toString()),
                  Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 30),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
//                                          articles[index]['author_name'],
                                        'https://googleflutter.com/sample_image.jpg',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(BackendService.articles[index]['author_name'],
                                    style: GoogleFonts.raleway(
                                        color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12, right: 8, left: 8, bottom: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  //  color: Colors.red.shade200,
                                  child: Text(BackendService.articles[index]['article_title'],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.raleway(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      )),
                                ),
                                //    Divider(color: Colors.grey),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 180),
                                  child: Text(
                                      DateFormat.yMMMMd('tr_TR')
                                          .format(DateTime.parse(BackendService.articles[index]['article_date'])),
                                      style: GoogleFonts.raleway(
                                          color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Hero(
                            tag: BackendService.articles[index]['id'],
                            child: Image(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(
                                BackendService.articles[index]['article_image'],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(width: 30),
                        Text(BackendService.articles[index]['blog_category_name'],
                            style: GoogleFonts.raleway(fontSize: 10, color: Colors.brown.withOpacity(0.2))),
                        SizedBox(width: 30),
                        Icon(Icons.library_books, color: Colors.brown.withOpacity(0.2), size: 15),
                        Text(BackendService.articles[index]['article_read'],
                            style: GoogleFonts.raleway(fontSize: 10, color: Colors.brown.withOpacity(0.2))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}

class BackendService {
  static final dio = new Dio();
  static int indicator = -3;
  String url = "http://blogsrvr.herokuapp.com/rest/message/getArticles";
  bool isLoading = false;
  static List articles = new List();

  static Future<List<PostModel>> getPosts() async {
    debugPrint("getPosts" + indicator.toString());

//    final responseBody =
//        (await http.get('http://jsonplaceholder.typicode.com/posts?_start=$offset&_limit=$limit')).body;
//
//    debugPrint("responseBody : " + responseBody);
    indicator = indicator + 3;
    final responseBody2 = (await dio.post(
      'http://blogsrvr.herokuapp.com/rest/message/getArticles',
      data: jsonEncode(<String, String>{"indicator": indicator.toString()}),
      options: Options(
        responseType: ResponseType.plain,
      ),
    ));

//    debugPrint("responseBody1 : " + responseBody2.data.toString());
    Map<String, dynamic> user = json.decode(responseBody2.data);
    debugPrint("responseBody2 : " + user['data'].toString());

    List tList = new List();
    for (int i = 0; i < user['data'].length; i++) {
      tList.add(user['data'][i]);
    }

    articles.addAll(tList);

    debugPrint("tList: " + tList.length.toString());

    // The response body is an array of items
    return PostModel.fromJsonList(user['data']);
//    return PostModel.fromJsonList(json.decode(responseBody));
  }
}

class PostModel {
  String title;
  String body;

  PostModel.fromJson(obj) {
//    this.title = obj['title'];
//    this.body = obj['body'];
//
    this.title = obj['article_title'];
    this.body = obj['article_image'];
  }

  static List<PostModel> fromJsonList(jsonList) {
    return jsonList.map<PostModel>((obj) => PostModel.fromJson(obj)).toList();
  }
}

class ImageModel {
  String title;
  String id;
  String thumbnailUrl;

  ImageModel.fromJson(obj) {
    this.title = obj['title'];
    this.id = obj['id'].toString();
    this.thumbnailUrl = obj['thumbnailUrl'];
  }

  static List<ImageModel> fromJsonList(jsonList) {
    return jsonList.map<ImageModel>((obj) => ImageModel.fromJson(obj)).toList();
  }
}
