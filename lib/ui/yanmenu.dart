import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/kategori.dart';
import 'kategori_article.dart';

class YanMenu extends StatefulWidget {
  final Future<Kategori> futureKategori;
  final String css;

  YanMenu(this.css, this.futureKategori);

  @override
  State<StatefulWidget> createState() => _YanMenu(css: css);
}

class _YanMenu extends State<YanMenu> {
  String url = "http://blogsrvr.herokuapp.com/rest/message/getCategories";
  Kategori kategori; //pokedex
  String css;

//  Future<Kategori> futureKategori; //veri

  _YanMenu({this.css});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

//yanmenu
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DrawerHeader(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                curve: Curves.easeInOutQuart,
                decoration: BoxDecoration(
                  //  color: Colors.orange,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(
                      'https://i.ibb.co/Yc9vnRk/logo.png',
                    ),
                  ),
                  //  color: Colors.orangeAccent,
                ),
              ),
            ),
            FutureBuilder(
                future: widget.futureKategori,
                builder: (context, AsyncSnapshot<Kategori> gelenKategori) {
                  if (gelenKategori.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (gelenKategori.connectionState == ConnectionState.done) {
                    if (gelenKategori.data.result.code == "1") {
                      return ExpansionTile(
                        leading: Icon(
                          Icons.perm_device_information,
                          color: Colors.orange,
                        ),
                        title: Text(
                          'Kategori',
                          style: TextStyle(fontSize: 16, color: Colors.orange),
                        ),
                        trailing: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.orange,
                        ),
                        children: <Widget>[
                          Container(
                            //  color: Colors.amberAccent.shade100,
                            height: MediaQuery.of(context).size.height - 400,
                            child: ListView.builder(
                                itemCount: gelenKategori.data.data.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Colors.orange.withOpacity(1.0),
                                    ),
                                    title: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => KategoriArticle(
                                                css: css,
                                                kategoriarticleId: gelenKategori.data.data[index].blogCategoryName)));
                                      },
                                      child: Text(
                                        gelenKategori.data.data[index].blogCategoryName,
                                        style: GoogleFonts.raleway(fontSize: 14, color: Colors.grey.shade50),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text("hata oluştu : \n" +
                            gelenKategori.data.result.code +
                            " : " +
                            gelenKategori.data.result.desc),
                      );
                    }
                  } else {
                    return Text("hata oluştu");
                  }
                }),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.orange,
              ),
              title: Text("iletişim", style: TextStyle(fontSize: 16, color: Colors.orange)),
              onTap: () {
//              Navigator.pushNamed(context, "/");
              },
            ),
            Divider(),
            Row(
              //  mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: _launchURL,
                  child: Text("Copyright © 2020 - Polar Vectors",
                      style: GoogleFonts.raleway(fontSize: 12, color: Colors.orange.withOpacity(1.0))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://polarvectors.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
