import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utarid/ui/anasayfa.dart';
import 'package:utarid/ui/detay.dart';
import 'package:utarid/ui/yanmenu.dart';
import 'package:http/http.dart' as http;
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
          primarySwatch: Colors.yellow,
          accentColor: Colors.tealAccent),
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
  String url = "http://blogsrvr.herokuapp.com/rest/message/getCategories";

  Kategori kategori; //pokedex
  Future<Kategori> futureKategori; //veri


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    futureKategori = kategoriVerileriGetir();

    sayfaAna=Anasayfa();
    sayfaYan=YanMenu(futureKategori);
    sayfaDetay=Detay();
    tumSayfalar = [sayfaAna, sayfaYan, sayfaDetay];

  }

  Future<Kategori> kategoriVerileriGetir() async {
    debugPrint("kategoriVerileriGetir");
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"": ""}),
    );
    debugPrint(response.body);
    var decodedJson = json.decode(response.body);
    kategori = Kategori.fromJson(decodedJson);
    return kategori;
  }

  //asil yapinin home kismi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:
      sayfaYan,
      appBar: AppBar(
        title: Text(
          "UTARID",
        ),

      ),
      body: sayfaAna,
//      body: secilenMenuItem <= tumSayfalar.length - 1
//          ? tumSayfalar[secilenMenuItem]
//          : tumSayfalar[0],

    );
  }
}