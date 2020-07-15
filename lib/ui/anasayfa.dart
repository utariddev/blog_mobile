import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detay.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  String url = "http://blogsrvr.herokuapp.com/rest/message/getArticles";
  static int indicator = 0;
  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  List articles = new List();
  final dio = new Dio();

  @override
  void initState() {
    this.getArticleDataFromHost();
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        getArticleDataFromHost();
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  void getArticleDataFromHost() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      final response = await dio.post(
        url,
        data: jsonEncode(<String, String>{"indicator": indicator.toString()}),
      );
      List tList = new List();
      for (int i = 0; i < response.data['data'].length; i++) {
        tList.add(response.data['data'][i]);
      }

      setState(() {
        isLoading = false;
        articles.addAll(tList);
        indicator = indicator + 3;
      });
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: articles.length + 1, // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == articles.length) {
          return _buildProgressIndicator();
        } else {
          return new Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Detay(articleId: articles[index]['id'])));
              },
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
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
                                    child: Image.network(
                                      'https://googleflutter.com/sample_image.jpg',
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(articles[index]['author_name'],
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
                                children: <Widget>[
                                  Container(
                                    //  color: Colors.red.shade200,
                                    child: Text(articles[index]['article_title'],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.raleway(
                                            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800)),
                                  ),
                                  Divider(color: Colors.grey),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 150),
                                    child: Text(articles[index]['article_date'],
                                        style: GoogleFonts.raleway(
                                            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400)),
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
                              tag: articles[index]['article_image'],
                              child: Image(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(
                                  articles[index]['article_image'],
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
                          Text(articles[index]['blog_category_name'],
                              style: GoogleFonts.raleway(fontSize: 10, color: Colors.brown.withOpacity(0.2))),
                          SizedBox(width: 30),
                          Icon(Icons.library_books, color: Colors.brown.withOpacity(0.2), size: 15),
                          Text(articles[index]['article_read'],
                              style: GoogleFonts.raleway(fontSize: 10, color: Colors.brown.withOpacity(0.2))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
      controller: _sc,
    );
  }
}
