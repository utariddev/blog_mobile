import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utarid/models/kategori.dart';
import 'package:utarid/ui/kategori_article.dart';

class YanMenu extends StatefulWidget {
  final Future<Kategori> futureKategori;

  YanMenu(this.futureKategori);

  @override
  State<StatefulWidget> createState() => _YanMenu();
}

class _YanMenu extends State<YanMenu> {
  String url = "http://blogsrvr.herokuapp.com/rest/message/getCategories";
  Kategori kategori; //pokedex
//  Future<Kategori> futureKategori; //veri

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

//yanmenu
  @override
  Widget build(BuildContext context) {
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
                  Text("UTARID", style: TextStyle(color: Colors.black12, fontSize: 20)),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Anasayfa", style: TextStyle(fontSize: 16)),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
          ),
          Divider(),
          FutureBuilder(
              future: widget.futureKategori,
              builder: (context, AsyncSnapshot<Kategori> gelenKategori) {
                if (gelenKategori.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (gelenKategori.connectionState == ConnectionState.done) {
                  return ExpansionTile(
                    leading: Icon(Icons.perm_device_information),
                    title: Text(
                      'Kategori',
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                    ),
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height - 400,
                        child: ListView.builder(
                            itemCount: gelenKategori.data.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => KategoriArticle(
                                            kategoriarticleId: gelenKategori.data.data[index].blogCategoryName)));
                                  },
                                  child: Text(
                                    gelenKategori.data.data[index].blogCategoryName,
                                    style: GoogleFonts.raleway(fontSize: 14, color: Colors.grey),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                } else {
                  return Text("vbghnn");
                }
              }),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("Iletisim", style: TextStyle(fontSize: 16)),
            onTap: () {
//              Navigator.pushNamed(context, "/");
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
