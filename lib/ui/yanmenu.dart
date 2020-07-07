import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:utarid/models/kategori.dart';

class YanMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _yanMenu();
}

class _yanMenu extends State<YanMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String url = "http://localhost:8080/blogserver/rest/message/getCategories";
  Kategori kategori;

  Future<Kategori> kategoriVerileriGetir() async {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"indicator": "0"}),
    );
    debugPrint(response.body);
    var decodedJson = json.decode(response.body);
    kategori = Kategori.fromJson(decodedJson);
    return kategori;
  }

//yanmenu
  @override
  Widget build(BuildContext context) {
//    return FutureBuilder(
//        future: kategoriVerileriGetir(),
//    builder: (context, AsyncSnapshot<Kategori> gelenEkrem) {
//    if (gelenEkrem.connectionState == ConnectionState.waiting) {
//    return Center(child: CircularProgressIndicator());
//    } else if (gelenEkrem.connectionState == ConnectionState.done) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.computer,
                    color: Colors.black12,
                    size: 50,
                  ),
                  Text("EK Yazilim",
                      style: TextStyle(color: Colors.black12, fontSize: 20)),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.amberAccent.shade100,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Anasayfa"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.perm_device_information),
            title: Text('Katagoriler'),
            trailing: Icon(Icons.arrow_drop_down),
            children: <Widget>[
              ListTile(
                title: Text('Tarihçemiz'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, "/tarihce");
                },
              ),
              ListTile(
                title: Text('Iletisim'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, "/iletisim");
                },
              ),
              ListTile(
                title: Text('Kurumsal'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, "/Kurumsal");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
