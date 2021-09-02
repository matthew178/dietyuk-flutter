import 'package:dietyuk/ClassPaket.dart';
import 'package:dietyuk/DetailPaket.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Daftar Paket Page"),
      //   backgroundColor: session.warna,
      // ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 25),
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
                            borderSide: BorderSide(color: Colors.grey[300]),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[200]),
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
              // Expanded(child: )
            ],
          ),
          SizedBox(height: 15),
          Container(
              child: Wrap(
                  children: List.generate(arrPaket.length, (index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPaket(
                              id: arrPaket[index].id,
                              konsultan: arrPaket[index].konsultan)));
                },
                child: Card(
                    child: Column(
                  children: [
                    Stack(children: <Widget>[
                      new Image.network(
                          session.ipnumber + "/" + arrPaket[index].gambar),
                      Positioned.fill(
                          top: 35,
                          right: 10,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              arrPaket[index].nama,
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
                              "By : " + arrPaket[index].konsultan,
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
                              arrPaket[index].durasi + " hari",
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
                                  frmt.format(int.parse(arrPaket[index].harga)),
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Biryani'),
                            ),
                          )),
                    ]),
                    // Container(
                    //   child: Image.network(
                    //       session.ipnumber + "/" + arrPaket[index].gambar),
                    // ),
                    // Container(
                    //     padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    //     child: Text(
                    //       arrPaket[index].nama,
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //       ),
                    //     )),
                    // Container(
                    //     padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    //     child: Text("By " + arrPaket[index].konsultan)),
                    // Container(child: Text(arrPaket[index].durasi + " hari")),
                    // Container(child: Text("Rp " + arrPaket[index].harga))
                  ],
                )));
          })))
        ],
      ),
      // body: new ListView.builder(
      //     itemCount: arrPaket.length == 0 ? 0 : arrPaket.length,
      //     itemBuilder: (context, index) {
      //       if (arrPaket.length == 0) {
      //         return Card(
      //           child: Text("Data empty"),
      //         );
      //       } else {
      //         return GestureDetector(
      //             onTap: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => DetailPaket(
      //                           id: arrPaket[index].id,
      //                           konsultan: arrPaket[index].konsultan)));
      //             },
      //             child: Card(
      //                 child: Column(
      //               children: [
      //                 Stack(children: <Widget>[
      //                   new Image.network(
      //                       session.ipnumber + "/" + arrPaket[index].gambar),
      //                   Positioned.fill(
      //                       top: 35,
      //                       child: Align(
      //                         alignment: Alignment.topRight,
      //                         child: Text(
      //                           arrPaket[index].nama,
      //                           style: TextStyle(
      //                               fontSize: 25,
      //                               fontWeight: FontWeight.w300,
      //                               fontFamily: "PoiretOne"),
      //                         ),
      //                       )),
      //                   Positioned.fill(
      //                       top: 65,
      //                       child: Align(
      //                         alignment: Alignment.topRight,
      //                         child: Text(
      //                           "By : " + arrPaket[index].konsultan,
      //                           style: TextStyle(
      //                               fontSize: 20, fontWeight: FontWeight.bold),
      //                         ),
      //                       )),
      //                   Positioned.fill(
      //                       top: 95,
      //                       child: Align(
      //                         alignment: Alignment.topRight,
      //                         child: Text(
      //                           arrPaket[index].durasi + " hari",
      //                           style: TextStyle(
      //                               fontSize: 20, fontWeight: FontWeight.bold),
      //                         ),
      //                       )),
      //                   Positioned.fill(
      //                       top: 125,
      //                       child: Align(
      //                         alignment: Alignment.topRight,
      //                         child: Text(
      //                           "Rp " +
      //                               frmt.format(
      //                                   int.parse(arrPaket[index].harga)),
      //                           style: TextStyle(
      //                               fontSize: 25,
      //                               fontWeight: FontWeight.w300,
      //                               fontFamily: 'Biryani'),
      //                         ),
      //                       )),
      //                 ]),
      //                 // Container(
      //                 //   child: Image.network(
      //                 //       session.ipnumber + "/" + arrPaket[index].gambar),
      //                 // ),
      //                 // Container(
      //                 //     padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
      //                 //     child: Text(
      //                 //       arrPaket[index].nama,
      //                 //       style: TextStyle(
      //                 //         fontSize: 20,
      //                 //       ),
      //                 //     )),
      //                 // Container(
      //                 //     padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      //                 //     child: Text("By " + arrPaket[index].konsultan)),
      //                 // Container(child: Text(arrPaket[index].durasi + " hari")),
      //                 // Container(child: Text("Rp " + arrPaket[index].harga))
      //               ],
      //             )));
      //       }
      //     }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, "/tambahpaket");
      //   },
      //   child: const Icon(Icons.add),
      //   backgroundColor: Colors.blue.shade200,
      // ),
    );
  }
}
