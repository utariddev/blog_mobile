import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utarid/models/categori_articles.dart';
import 'package:utarid/ui/detay.dart';

class KategoriArticle extends StatefulWidget {
  var kategoriarticleId;

  KategoriArticle({this.kategoriarticleId});

  @override
  _KategoriArticleState createState() => _KategoriArticleState();
}

class _KategoriArticleState extends State<KategoriArticle> {
  String url = "http://blogsrvr.herokuapp.com/rest/message/getCategoryArticles";
  Kategoriarticle kategoriArticle;
  final dio = new Dio();

  @override
  void initState() {
//    KategoriArticleVerileriGetir2();
  }

//  Future<Kategoriarticle> KategoriArticleVerileriGetir() async {
//    var response = await http.post(
//      url,
//      headers: <String, String>{
//        'Content-Type': 'application/json; charset=UTF-8',
//      },
//      body: jsonEncode(<String, String>{"categoryName": widget.kategoriarticleId}),
//    );
////    debugPrint(response.body);
//    var decodedJson = json.decode(response.body);
//    kategoriArticle = Kategoriarticle.fromJson(decodedJson);
//    return kategoriArticle;
//  }

  Future<Kategoriarticle> KategoriArticleVerileriGetir() async {
    debugPrint("KategoriArticleVerileriGetir2");
    final response = await dio.post(
      url,
      data: jsonEncode(<String, String>{"categoryName": widget.kategoriarticleId}),
    );
    debugPrint("KategoriArticleVerileriGetir2 - 1 : " + response.toString());
//    debugPrint("KategoriArticleVerileriGetir2 - 2 : " + response.data.toString());
    var decodedJson = json.decode(response.toString());
    kategoriArticle = Kategoriarticle.fromJson(decodedJson);
    return kategoriArticle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Utarid"),
      ),
      body: Hero(
        tag: widget.kategoriarticleId,
        child: FutureBuilder(
            future: KategoriArticleVerileriGetir(),
            builder: (context, AsyncSnapshot<Kategoriarticle> gelenKategoriArticle) {
              if (gelenKategoriArticle.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (gelenKategoriArticle.connectionState == ConnectionState.done) {
                debugPrint("articleVerileriGetir gelenKategoriArticle : " + gelenKategoriArticle.toString());
                return ListView.builder(
//                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                    itemCount: gelenKategoriArticle.data.data.length,
                    itemBuilder: (context, index) {
//                          return Column(
//                            children: <Widget>[
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Detay(articleId: gelenKategoriArticle.data.data[index].id)));
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            color: Colors.grey.shade200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              (index + 1).toString(),
                                              style: GoogleFonts.raleway(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 50,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        //   VerticalDivider(width: 30,color: Colors.red,indent: 20,),
                                        Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              gelenKategoriArticle.data.data[index].articleTitle,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.raleway(
                                                  color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
//``
//                                              SizedBox(
//                                                width: 50,
//                                              ),``

                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                      /*gelenKategoriArticle.data.data[index].articleDate.toString(),*/
                                                      "20 Mayis 2020",
                                                      style: GoogleFonts.raleway(
                                                          color: Colors.black,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w400)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      Text(gelenKategoriArticle.data.data[index].authorName,
                                                          style: GoogleFonts.raleway(
                                                              color: Colors.black,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w400)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Container(
                                                        height: 50,
                                                        width: 50,
                                                        child: Image(
                                                          //  fit: BoxFit.contain,
                                                          image: NetworkImage(
                                                              'https://googleflutter.com/sample_image.jpg'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      //   Divider(),
//                            ],
//                          );
                    });
              } else {
                return Text("aaa");
              }
            }),
      ),
    );
  }
}
