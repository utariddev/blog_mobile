import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:utarid/constants.dart';

import '../models/categori_articles.dart';
import 'detay.dart';

class KategoriArticle extends StatefulWidget {
  var kategoriarticleId;

  KategoriArticle({this.kategoriarticleId});

  @override
  _KategoriArticleState createState() => _KategoriArticleState();
}

class _KategoriArticleState extends State<KategoriArticle> {
  // String url = "http://blogsrvr.herokuapp.com/rest/message/getCategoryArticles";
  String url = Constants().getUrlForCategories();
  Kategoriarticle kategoriArticle;
  Future<Kategoriarticle> _kategoriArticle;
  final dio = new Dio();

  @override
  void initState() {
    _kategoriArticle = kategoriArticleVerileriGetir();
    super.initState();
  }

  Future<Kategoriarticle> kategoriArticleVerileriGetir() async {
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
    initializeDateFormatting('tr');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "utarid",
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
      ),
      body: Hero(
        tag: widget.kategoriarticleId,
        child: FutureBuilder(
            future: _kategoriArticle,
            builder: (context, AsyncSnapshot<Kategoriarticle> gelenKategoriArticle) {
              if (gelenKategoriArticle.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (gelenKategoriArticle.connectionState == ConnectionState.done) {
                debugPrint("articleVerileriGetir gelenKategoriArticle : " + gelenKategoriArticle.toString());
                if (gelenKategoriArticle.data.result.code == "1") {
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
                              color: Colors.grey.shade50,
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
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text(
                                                        DateFormat.yMMMMd('tr_TR')
                                                            .format(gelenKategoriArticle.data.data[index].articleDate),
                                                        /*gelenKategoriArticle.data.data[index].articleDate.toString(),*/
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
                  return Center(
                    child: Text("hata oluştu : \n" +
                        gelenKategoriArticle.data.result.code +
                        " : " +
                        gelenKategoriArticle.data.result.desc),
                  );
                }
              } else {
                return Text("hata oluştu");
              }
            }),
      ),
    );
  }
}
