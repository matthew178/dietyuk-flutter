import 'package:dietyuk/ClassPaket.dart';
import 'package:dietyuk/DetailPaket.dart';
import 'package:dietyuk/FilterPaket.dart';
import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'ClassPaket.dart';
import 'package:intl/intl.dart';

class Daftarpaket extends StatefulWidget {
  @override
  DaftarpaketState createState() => DaftarpaketState();
}

class DaftarpaketState extends State<Daftarpaket> {
  List<ClassPaket> arrPaket = new List();
  NumberFormat frmt = new NumberFormat(',000');
  String search = "";
  @override
  void initState() {
    super.initState();
    getPaket();
  }

  Future<List<ClassPaket>> getPaket() async {
    // await Future.delayed(
    //   Duration(seconds: 2),
    // );
    List<ClassPaket> arrPaket = new List();
    Map paramData = {};
    var parameter = json.encode(paramData);
    http.post(session.ipnumber + "/getpaket",
        headers: {"Content-Type": "application/json"}).then((res) {
      var data = json.decode(res.body);
      data = data[0]['paket'];
      for (int i = 0; i < data.length; i++) {
        ClassPaket databaru = ClassPaket(
            data[i]['id_paket'].toString(),
            data[i]['estimasiturun'].toString(),
            data[i]['harga'].toString(),
            data[i]['durasi'].toString(),
            data[i]['status'].toString(),
            data[i]['rating'].toString(),
            data[i]['nama'].toString(),
            data[i]['nama_paket'].toString(),
            data[i]['deskripsi'].toString(),
            data[i]['background'].toString());
        arrPaket.add(databaru);
      }
      setState(() => this.arrPaket = arrPaket);
      setState(() => session.paketSemua = this.arrPaket);
      print(arrPaket.length);
      return arrPaket;
    }).catchError((err) {
      print(err);
    });
  }

  Future<List<ClassPaket>> searchPaket(String cari) async {
    List<ClassPaket> tempPaket = new List();
    Map paramData = {"cari": cari};
    var parameter = json.encode(paramData);
    http.post(session.ipnumber + "/searchPaket",
        headers: {"Content-Type": "application/json"}).then((res) {
      var data = json.decode(res.body);
      data = data[0]['paket'];
      for (int i = 0; i < data.length; i++) {
        ClassPaket databaru = ClassPaket(
            data[i]['id_paket'].toString(),
            data[i]['estimasiturun'].toString(),
            data[i]['harga'].toString(),
            data[i]['durasi'].toString(),
            data[i]['status'].toString(),
            data[i]['rating'].toString(),
            data[i]['nama'].toString(),
            data[i]['nama_paket'].toString(),
            data[i]['deskripsi'].toString(),
            data[i]['background'].toString());
        tempPaket.add(databaru);
      }
      setState(() => this.arrPaket = tempPaket);
      print(arrPaket.length);
      return arrPaket;
    }).catchError((err) {
      print(err);
    });
  }

  Future<List<String>> getData() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      "New Value1",
      "New Value2",
      "New Value3",
      "New Value4",
      "New Value5",
      "New Value6"
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Paket Page"),
        backgroundColor: session.warna,
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 25, right: 5, top: 25),
                            child: TextField(
                              onSubmitted: (String str) {
                                setState(() {
                                  search = str;
                                });
                                searchPaket(search);
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.grey[200]),
                                  ),
                                  contentPadding: EdgeInsets.all(15),
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                      // fontFamily: "Roboto",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                      fontSize: 18),
                                  prefixIcon: Icon(Icons.search,
                                      size: 30, color: Colors.black)),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FilterPaket()));
                              },
                              icon: Icon(Icons.filter_alt))),
                      SizedBox(width: 5)
                    ],
                  ))
              // Expanded(child: )
            ],
          ),
          SizedBox(height: 15),
          Container(
              child: Wrap(
                  children: List.generate(session.paketSemua.length, (index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPaket(
                              id: arrPaket[index].id,
                              konsultan: session.paketSemua[index].konsultan)));
                },
                child: Card(
                    child: Column(
                  children: [
                    Stack(children: <Widget>[
                      new Image.network(session.ipnumber +
                          "/" +
                          session.paketSemua[index].gambar),
                      Positioned.fill(
                          top: 35,
                          right: 10,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              session.paketSemua[index].nama,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "PoiretOne"),
                            ),
                          )),
                      Positioned.fill(
                          top: 65,
                          right: 10,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "By : " + session.paketSemua[index].konsultan,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Positioned.fill(
                          top: 95,
                          right: 10,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              session.paketSemua[index].durasi + " hari",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Positioned.fill(
                          top: 125,
                          right: 10,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "Rp " +
                                  frmt.format(int.parse(
                                      session.paketSemua[index].harga)),
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Biryani'),
                            ),
                          )),
                    ]),
                  ],
                )));
          })))
        ],
      ),
      // body: Center(
      //   child: FutureBuilder(
      //     future: getData(),
      //     builder: (context, snapshot) {
      //       return snapshot.connectionState == ConnectionState.waiting
      //           ? CircularProgressIndicator()
      //           : Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Column(
      //                 children: List.generate(
      //                     snapshot.data.length,
      //                     (index) => Text(
      //                           snapshot.data[index],
      //                           style: TextStyle(fontSize: 25),
      //                         )),
      //               ),
      //             );
      //     },
      //   ),
      // ),
    );
  }
}
