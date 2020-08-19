import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/article.dart';

//class Detay extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    throw UnimplementedError();
//  }
//
//}
//class _DetayState extends State<Detay>{
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    throw UnimplementedError();
//  }
//
//}

class Detay extends StatefulWidget {
  var articleId;

  Detay({this.articleId});

  @override
  _DetayState createState() => _DetayState();
}

class _DetayState extends State<Detay> {
  String url = "http://blogsrvr.herokuapp.com/rest/message/getArticle";
  Article article;
  final dio = new Dio();
  WebViewController _controller;

  Future<Article> articleVerileriGetir() async {
    dio.options.headers = {"Content-Type": "application/json; charset=UTF-8"};
    final response = await dio.post(
      url,
      data: jsonEncode(<String, String>{"articleID": widget.articleId}),
    );
    debugPrint("articleVerileriGetir response.data : " + response.toString());

    var decodedJson = json.decode(response.toString());
    article = Article.fromJson(decodedJson);
    return article;
  }

//  Future<Article> articleVerileriGetir() async {
//    debugPrint("detay:articleVerileriGetir ");
//    var response = await http.post(
//      url,
//      headers: <String, String>{
//        'Content-Type': 'application/json; charset=UTF-8',
//      },
//      body: jsonEncode(<String, String>{"articleID": widget.articleId}),
//    );
//    debugPrint(response.body);
//    var decodedJson = json.decode(response.body);
//    article = Article.fromJson(decodedJson);
//    return article;
//  }

  loadHtml(String a) async {
    debugPrint("detay:_loadHtmlFromAssets");
    String fileText = """
    <html>
<body>
<style type="text/css">
.myNewStyle {
   font-family: Verdana, Arial, Helvetica, sans-serif;
   font-weight: bold;
   color: #FF0000;
}
</style>
<p class="myNewStyle">Msady CSS styled text1</p>
<p>My CSS styled text2</p>
<p class="myNewStyle">My CSS styled text3</p>
<ul>
<li class="myNewStyle">1</li>
<li>2</li>
</ul>
</body>
</html>
    """;
    _controller.loadUrl(Uri.dataFromString(a, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Utarid",
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Hero(
          tag: widget.articleId,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final size = Size(constraints.maxHeight, constraints.maxWidth);
                  return CachingFutureBuilder<Article>(
                    key: ValueKey(size),
                    futureFactory: () => articleVerileriGetir(),
                    builder: (context, AsyncSnapshot<Article> gelenArticle) {
                      if (gelenArticle.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (gelenArticle.connectionState == ConnectionState.done) {
//              return Text(gelenArticle.data.data.length.toString());

                        return Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(gelenArticle.data.data[0].articleTitle,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.raleway(
                                                    color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 60),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                  DateFormat.yMMMMd('tr_TR')
                                                      .format(gelenArticle.data.data[0].articleDate),
                                                  style: GoogleFonts.raleway(
                                                      color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Text(gelenArticle.data.data[0].authorName,
                                                    style: GoogleFonts.raleway(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w400)),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                        'https://googleflutter.com/sample_image.jpg',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
//                              flex: 4,
                              child: Row(
                                children: <Widget>[
                                  Container(
//                                    height: 200,
                                    width: constraints.maxWidth,
//                                    child: Text(gelenArticle.data.data[0].articleText),
                                    child: WebView(
                                      initialUrl: 'about:blank',
                                      onWebViewCreated: (WebViewController webViewController) {
                                        _controller = webViewController;
                                        loadHtml(gelenArticle.data.data[0].articleText);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Divider(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(gelenArticle.data.data[0].blogCategoryName,
                                      style: GoogleFonts.raleway(fontSize: 10, color: Colors.brown.withOpacity(0.4))),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Icon(Icons.library_books, color: Colors.brown.withOpacity(0.4), size: 15),
                                  Text(gelenArticle.data.data[0].articleRead,
                                      style: GoogleFonts.raleway(fontSize: 10, color: Colors.brown.withOpacity(0.2))),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Text("a");
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CachingFutureBuilder<T> extends StatefulWidget {
  final Future<T> Function() futureFactory;
  final AsyncWidgetBuilder<T> builder;

  const CachingFutureBuilder({Key key, @required this.futureFactory, @required this.builder}) : super(key: key);

  @override
  _CachingFutureBuilderState createState() => _CachingFutureBuilderState<T>();
}

class _CachingFutureBuilderState<T> extends State<CachingFutureBuilder<T>> {
  Future<T> _future;

  @override
  void initState() {
    _future = widget.futureFactory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: widget.builder,
    );
  }
}
