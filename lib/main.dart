import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'constants.dart';
import 'models/kategori.dart';
import 'ui/detay.dart';
import 'ui/yanmenu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'utarid',
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
  final dio = new Dio();
  Future<Kategori> futureKategori; //veri
//  Future<Constant> futureConstant;
  YanMenu sayfaYan;
  Kategori kategori;
  String css = "";

  @override
  void initState() {
    super.initState();

    futureKategori = kategoriVerileriGetir();
    cssVerisiGetir().then((String result) {
      setState(() {
        css = result;
      });
    });
    sayfaYan = YanMenu(futureKategori);
  }

  void showAlertDialog(String message, String title) {
    AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        FlatButton(
          child: Text("Tamam"),
          onPressed: () {
            //Navigator.pop();
          },
        ),
      ],
      elevation: 12,
      backgroundColor: Colors.grey,
    );
  }

  Future<Kategori> kategoriVerileriGetir() async {
    final response = await dio.post(
      Constants.URL_GET_CATEGORIES,
      data: jsonEncode(<String, String>{"": ""}),
    );
    if (response.statusCode != 200) {
      showAlertDialog("Bir Hata Oluştu :( Lütfen daha sonra tekrar deneyiniz", "Hata");
      return null;
    }

//    debugPrint("kategoriVerileriGetir response : " + response.toString());
    var decodedJson = json.decode(response.toString());
    kategori = Kategori.fromJson(decodedJson);
    return kategori;
  }

  Future<String> cssVerisiGetir() async {
    final response = await dio.post(
      Constants.URL_GET_CONSTANT,
      data: jsonEncode(<String, String>{"key": "css"}),
    );
    //debugPrint("cssVerisiGetir response : " + response.toString());
    var decodedJson = json.decode(response.toString());
    //debugPrint("cssVerisiGetir data : " + decodedJson["data"]);
    return decodedJson["data"];
//    constant = Constant.fromJson(decodedJson);
//    return constant;
  }

  Future<void> getPost() async {
    final responseBody = (await dio.get('http://jsonplaceholder.typicode.com/posts?_start=1&_limit=5'));
    debugPrint("responseBody : " + responseBody.data.toString());
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint("aaa css : " + css);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(right: Radius.circular(50)),
                border: Border.all(
                  color: Colors.orange.shade600.withOpacity(0.6),
                  width: 1,
                )),
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(50)),
              child: Theme(
                data: Theme.of(context).copyWith(canvasColor: Colors.transparent.withOpacity(0.4)),
                child: sayfaYan,
              ),
            ),
          ),
        ),
        body: PagewiseSliverListExample(css: css),
      ),
    );
  }
}

class PagewiseSliverListExample extends StatelessWidget {
//  static const int PAGE_SIZE = 1000;
  int indicator = -2;

//  YanMenu sayfaYan;
  String css = "";

  PagewiseSliverListExample({this.css});

  @override
  Widget build(BuildContext context) {
//    debugPrint("PagewiseSliverListExample css : " + css);
    initializeDateFormatting('tr');
    return SafeArea(
      child: Material(
        child: CustomScrollView(slivers: [
          SliverPersistentHeader(
            delegate: MySliverAppBar(expandedHeight: 200),
            pinned: true,
          ),
          PagewiseSliverList(
            pageSize: 3,
            itemBuilder: this._itemBuilder,
            pageFuture: (pageIndex) => BackendService.getPosts(),
          )
        ]),
      ),
    );
  }

  Widget _itemBuilder(context, PostModel entry, index) {
    debugPrint("main itembuilder:" + index.toString());
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Detay(
                        css: css,
                        articleId: BackendService.articles[index]['id'],
                      )
//articleId: articles[index]['id']  articleId: BackendService.articles[_]['id'],
                  ));
            },
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade50,
              elevation: 6,
              child: Container(
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
                                        BackendService.articles[index]['author_image'],
//                                        'https://googleflutter.com/sample_image.jpg',
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
                      height: 15,
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
                      height: 25,
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
  static String url = "http://blogsrvr.herokuapp.com/rest/message/getArticles";
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
      url,
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

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
//        FlexibleSpaceBar(background:Image.network(
//          "https://rasyonalist.org/wp-content/uploads/2017/04/M31-by-Jacob-Bers.jpg",
//          fit: BoxFit.cover,
//        ) ,),
        Image.network(
          "https://us.123rf.com/450wm/stori/stori1810/stori181000093/110313969-world-map-on-a-technological-background-glowing-lines-symbols-of-the-internet-radio-television-mobil.jpg?ver=6",
//"https://cdn.blueswandaily.com//2018/03/iStock-639314512.jpg",
          //  "https://us.123rf.com/450wm/peshkov/peshkov1806/peshkov180600314/102902999-male-hand-writing-mathematical-formulas-on-blurry-background-science-and-algebra-concept-double-expo.jpg?ver=6",
//"https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/4ef87ea4-c054-4744-a61d-d4f8257c0725/d2kqrwa-6b66431e-dc6d-4b84-a5fa-d656c47fc8b7.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3sicGF0aCI6IlwvZlwvNGVmODdlYTQtYzA1NC00NzQ0LWE2MWQtZDRmODI1N2MwNzI1XC9kMmtxcndhLTZiNjY0MzFlLWRjNmQtNGI4NC1hNWZhLWQ2NTZjNDdmYzhiNy5qcGcifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6ZmlsZS5kb3dubG9hZCJdfQ.ZLCbdKMpnBYIVlD5_C8ZUWgbzdEw87dJis3mrcLqDqc",
          fit: BoxFit.cover,
        ),
        Opacity(
          opacity: shrinkOffset / expandedHeight,
          child: Center(
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "utarid",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              color: Colors.transparent,
              elevation: 80,
              child: SizedBox(
                height: expandedHeight,
                width: MediaQuery.of(context).size.width / 2,
                child: Image(
                  image: NetworkImage(
                    "https://i.ibb.co/Yc9vnRk/logo.png",
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
