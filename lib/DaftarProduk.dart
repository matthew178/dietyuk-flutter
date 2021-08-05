import 'package:dietyuk/DetailProdukKonsultan.dart';

import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'ClassProduk.dart';

class DaftarProduk extends StatefulWidget {
  @override
  DaftarProdukState createState() => DaftarProdukState();
}

class DaftarProdukState extends State<DaftarProduk> {
  List<ClassProduk> arrProduk = new List();
  @override
  void initState() {
    super.initState();
    getProduk();
  }

  Future<List<ClassProduk>> getProduk() async {
    List<ClassProduk> tempProduk = new List();
    Map paramData = {'id': session.userlogin};
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/getprodukbykonsultan",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      var data = json.decode(res.body);
      data = data[0]['produk'];
      for (int i = 0; i < data.length; i++) {
        ClassProduk databaru = ClassProduk(
            data[i]['kodeproduk'].toString(),
            data[i]['konsultan'].toString(),
            data[i]['namaproduk'].toString(),
            data[i]['kodekategori'].toString(),
            data[i]['kemasan'].toString(),
            data[i]['harga'].toString(),
            data[i]['foto'].toString(),
            data[i]['deskripsi'].toString(),
            data[i]['status'].toString(),
            data[i]['varian'].toString(),
            data[i]['fotokonsultan'].toString(),
            data[i]['konsultan'].toString());
        tempProduk.add(databaru);
      }
      setState(() => this.arrProduk = tempProduk);
      return tempProduk;
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Produk Page"),
        backgroundColor: session.warna,
      ),
      body: new ListView.builder(
          itemCount: arrProduk.length == 0 ? 0 : arrProduk.length,
          itemBuilder: (context, index) {
            if (arrProduk.length == 0) {
              return Card(
                child: Text("Data empty"),
              );
            } else {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailProdukKonsultan(
                                id: arrProduk[index].kodeproduk)));
                  },
                  child: Card(
                      child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Image.network(
                            session.ipnumber +
                                "/gambar/" +
                                arrProduk[index].foto,
                            fit: BoxFit.cover),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Nama Produk :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(arrProduk[index].namaproduk),
                            ),
                            Container(
                              child: Text(
                                "Harga Produk :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text("Rp " + arrProduk[index].harga),
                            ),
                            Container(
                              child: Text(
                                "Varian Produk :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(arrProduk[index].varian),
                            ),
                            Container(
                              child: Text(
                                "Kemasan Produk :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(arrProduk[index].kemasan),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )));
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/tambahproduk");
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue.shade200,
      ),
    );
  }
}
