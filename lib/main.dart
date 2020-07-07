import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utarid/ui/anasayfa.dart';
import 'package:utarid/ui/detay.dart';
import 'package:utarid/ui/yanmenu.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sayfaAna=Anasayfa();
    sayfaYan=YanMenu();
    sayfaDetay=Detay();
    tumSayfalar = [sayfaAna, sayfaYan, sayfaDetay];
  }

  //asil yapinin home kismi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:
      YanMenu(),
      appBar: AppBar(
        title: Text(
          "UTARID",
        ),

      ),
      body: Anasayfa(),
//      body: secilenMenuItem <= tumSayfalar.length - 1
//          ? tumSayfalar[secilenMenuItem]
//          : tumSayfalar[0],

    );
  }
}