import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:utarid/models/article.dart';

class Detay extends StatefulWidget {
  var articleId;

  Detay({this.articleId});

  @override
  _DetayState createState() => _DetayState();
}

class _DetayState extends State<Detay> {
  String url = "http://blogsrvr.herokuapp.com/rest/message/getArticle";
  Article article;

  Future<Article> articleVerileriGetir() async {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"articleID": widget.articleId}),
    );
//    debugPrint(response.body);
    var decodedJson = json.decode(response.body);
    article = Article.fromJson(decodedJson);
    return article;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Utarid"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Hero(
          tag: widget.articleId,
          child: Material(
            // color: Colors.red.shade100,
            elevation: 6,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: articleVerileriGetir(),
                  builder: (context, AsyncSnapshot<Article> gelenArticle) {
                    if (gelenArticle.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (gelenArticle.connectionState == ConnectionState.done) {
                      return ListView.builder(
//                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                          itemCount: gelenArticle.data.data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                Padding(
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
                                              Text(gelenArticle.data.data[index].articleTitle,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.mada(
                                                      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            //  mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Text(gelenArticle.data.data[index].articleDate.toString(),
                                                  style: GoogleFonts.mada(
                                                      color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Text(gelenArticle.data.data[index].authorName,
                                                      style: GoogleFonts.mada(
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
                                                    child: Image(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
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
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Image(
                                          fit: BoxFit.fitWidth,
                                          image: NetworkImage(
                                            gelenArticle.data.data[index].articleImage,
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        gelenArticle.data.data[index].articleText,
                                        style:
                                            GoogleFonts.montserrat(fontSize: 10, color: Colors.brown.withOpacity(0.8)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(gelenArticle.data.data[index].blogCategoryName,
                                        style:
                                            GoogleFonts.montserrat(fontSize: 10, color: Colors.brown.withOpacity(0.4))),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Icon(Icons.library_books, color: Colors.brown.withOpacity(0.4), size: 15),
                                    Text(gelenArticle.data.data[index].articleRead,
                                        style:
                                            GoogleFonts.montserrat(fontSize: 10, color: Colors.brown.withOpacity(0.2))),
                                  ],
                                ),
                              ],
                            );
                          });
                    } else {
                      return Text("aaa");
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
