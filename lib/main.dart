import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utarid/constant.dart';
import 'package:utarid/ui/anasayfa.dart';
import 'package:utarid/ui/detay.dart';
import 'package:utarid/ui/yanmenu.dart';

import 'models/kategori.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTARID',
      theme: ThemeData(
          fontFamily: 'Genel',
          // canvasColor: Colors.lightBlue,  //todo:ekranin rengini ayarlar
          primarySwatch: Colors.orange,
          accentColor: Colors.orangeAccent),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  int secilenMenuItem = 0;
  List<Widget> tumSayfalar;
  Anasayfa sayfaAna;
  YanMenu sayfaYan;
  Detay sayfaDetay;

  final dio = new Dio();
  Kategori kategori; //pokedex
  Future<Kategori> futureKategori; //veri

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    futureKategori = kategoriVerileriGetir();

    sayfaAna = Anasayfa();
    sayfaYan = YanMenu(futureKategori);
    sayfaDetay = Detay();
    tumSayfalar = [sayfaAna, sayfaYan, sayfaDetay];
  }

  Future<Kategori> kategoriVerileriGetir() async {
    final response = await dio.post(
      Constant.URL_GET_CATEGORIES,
      data: jsonEncode(<String, String>{"": ""}),
    );
//    debugPrint("KategoriArticleVerileriGetir2 - 2 : " + response.toString());
    var decodedJson = json.decode(response.toString());
    kategori = Kategori.fromJson(decodedJson);
    return kategori;
  }

  //asil yapinin home kismi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sayfaYan,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Text(
                "UTARID",
              ),
            ),
            SizedBox(width: 70),
            Expanded(
              flex: 1,
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(
                      'https://i.ibb.co/Yc9vnRk/logo.png',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: sayfaAna,
//      body: secilenMenuItem <= tumSayfalar.length - 1
//          ? tumSayfalar[secilenMenuItem]
//          : tumSayfalar[0],
    );
  }
}
