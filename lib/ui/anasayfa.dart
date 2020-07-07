import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:utarid/models/article.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  // List<Veri> tumVeriler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    tumVeriler = [
//      Veri(),
//    ];
  }

  String url = "http://blogsrvr.herokuapp.com/rest/message/getArticles";
  Article article;

  Future<Article> articleVerileriGetir() async {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"indicator": "0"}),
    );
    debugPrint(response.body);
    var decodedJson = json.decode(response.body);
    article = Article.fromJson(decodedJson);
    return article;
  }

  //ana yapinin body kismi
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: articleVerileriGetir(),
        builder: (context, AsyncSnapshot<Article> gelenEkrem) {
          if (gelenEkrem.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (gelenEkrem.connectionState == ConnectionState.done) {
            return ListView.builder(
//                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                itemCount: gelenEkrem.data.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.shade100,
                      elevation: 6,
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 10, right: 10, bottom: 40),
//            height: 500,
//            width: 500,
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
//                                      child: FadeInImage.assetNetwork(
//                                        placeholder: "assets/loading.gif",
//                                        image: poke.img,
//                                        fit: BoxFit.contain,
//                                        child: Image(image:NetworkImage(gelenEkrem.data.data[index].articleImage)),
                                          child: Image.network(
                                              'https://googleflutter.com/sample_image.jpg'),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
//                                              image: FadeInImage(
//                                                image:
//                                                  'articleImage'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            gelenEkrem
                                                .data.data[index].authorName,
                                            style: GoogleFonts.mada(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12,
                                        right: 8,
                                        left: 8,
                                        bottom: 8.0),
                                    child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Container(
                                          color: Colors.red.shade200,
                                          child: Text(
                                              gelenEkrem.data.data[index]
                                                  .articleTitle,
                                              //  overflow: TextOverflow.visible,
                                              textAlign: TextAlign.center,
                                              //  maxLines: 5,
//                                          textWidthBasis: TextWidthBasis.longestLine,
                                              style: GoogleFonts.mada(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800)),
                                        ),
                                        Divider(color: Colors.grey),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 150),
                                          child: Text(
                                              gelenEkrem
                                                  .data.data[index].articleDate
                                                  .toString(),
                                              style: GoogleFonts.mada(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
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
                                  child: Image(
                                      fit: BoxFit.fitWidth,
                                      image: NetworkImage(gelenEkrem
                                          .data.data[index].articleImage)),
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
                                Text(
                                    gelenEkrem
                                        .data.data[index].blogCategoryName,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        color: Colors.brown.withOpacity(0.2))),
                                SizedBox(width: 30),
                                Icon(Icons.library_books,
                                    color: Colors.brown.withOpacity(0.2),
                                    size: 15),
                                Text(gelenEkrem.data.data[index].articleRead,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        color: Colors.brown.withOpacity(0.2))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Text("bu ne bicim hikaye boyle");
          }
        });

    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red.shade100,
          elevation: 6,
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 40),
//            height: 500,
//            width: 500,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                image: AssetImage('asset/chanellogo.jpg'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text("Yazar Adi:",
                              style: GoogleFonts.mada(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 50),
                          child: Text("BASLIK",
                              style: GoogleFonts.mada(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 150),
                          child: Text("Tarih:",
                              style: GoogleFonts.mada(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                        fit: BoxFit.cover,
//                        height: 100,
//                        width: 300,
                        image: AssetImage('asset/chanellogo.jpg')),
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
                    Text("Kategori",
                        style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: Colors.brown.withOpacity(0.2))),
                    SizedBox(width: 30),
                    Icon(Icons.sms,
                        color: Colors.brown.withOpacity(0.2), size: 25),
                    Text("325",
                        style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: Colors.brown.withOpacity(0.2))),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red.shade100,
          elevation: 6,
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 40),
//            height: 500,
//            width: 500,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                image: AssetImage('asset/chanellogo.jpg'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text("Yazar Adi:",
                              style: GoogleFonts.mada(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 50),
                          child: Text("BASLIK",
                              style: GoogleFonts.mada(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 150),
                          child: Text("Tarih:",
                              style: GoogleFonts.mada(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                        fit: BoxFit.cover,
//                        height: 100,
//                        width: 300,
                        image: AssetImage('asset/chanellogo.jpg')),
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
                    Text("Kategori",
                        style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: Colors.brown.withOpacity(0.2))),
                    SizedBox(width: 30),
                    Icon(Icons.sms,
                        color: Colors.brown.withOpacity(0.2), size: 25),
                    Text("325",
                        style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: Colors.brown.withOpacity(0.2))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
//
//Padding(
//padding: const EdgeInsets.only(
//top: 10, left: 10),
//child: Text(gelenEkrem.data.data[index].articleTitle,
//style: GoogleFonts.mada(
//color: Colors.black,
//fontSize: 16,
//fontWeight: FontWeight.w800),
//overflow: TextOverflow.fade,textAlign: TextAlign.center,
//maxLines: 5,textWidthBasis: TextWidthBasis.parent,
//),
//),
