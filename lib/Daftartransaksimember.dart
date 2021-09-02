import 'package:dietyuk/AwalPaket.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'ClassBeliPaket.dart';

class Daftartransaksimember extends StatefulWidget {
  @override
  DaftartransaksimemberState createState() => DaftartransaksimemberState();
}

class DaftartransaksimemberState extends State<Daftartransaksimember> {
  List<Transaksibelipaket> arrTransaksi = new List();
  List<Transaksibelipaket> onProses = new List();
  List<Transaksibelipaket> selesai = new List();
  List<Transaksibelipaket> batal = new List();
  DateTime tglnow = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    super.initState();
    getTransaksiBelumSelesai();
    transaksiOnProses();
    getTransaksiSelesai();
    getTransaksiBatal();
  }

  Future<List<Transaksibelipaket>> getTransaksiBelumSelesai() async {
    List<Transaksibelipaket> arrTrans = new List();
    Map paramData = {'user': session.userlogin};
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/getPaketBelumSelesai",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      var data = json.decode(res.body);
      data = data[0]['transaksi'];
      for (int i = 0; i < data.length; i++) {
        Transaksibelipaket databaru = Transaksibelipaket(
            data[i]['id'].toString(),
            data[i]['idpaket'].toString(),
            data[i]['iduser'].toString(),
            data[i]['tanggalbeli'].toString(),
            data[i]['tanggalaktifasi'].toString(),
            data[i]['tanggalselesai'].toString(),
            data[i]['keterangan'].toString(),
            data[i]['durasi'].toString(),
            data[i]['totalharga'].toString(),
            data[i]['status'].toString(),
            data[i]['nama_paket'].toString(),
            data[i]['nama'].toString());
        arrTrans.add(databaru);
      }
      setState(() => this.arrTransaksi = arrTrans);
      return arrTrans;
    }).catchError((err) {
      print(err);
    });
  }

  void showAlert(String di, String packet) {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 230.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
              child: new Container(
                  child: new Text(
                      "Program akan dimulai besok, aktivasi paket sekarang ?")),
              flex: 2,
            ),
            new Expanded(
              child: Row(
                children: [
                  SizedBox(width: 30),
                  Container(
                    child: new RaisedButton(
                      onPressed: () {
                        aktivasiPaket(di, packet);
                        Navigator.of(context, rootNavigator: true).pop(true);
                      },
                      padding: new EdgeInsets.all(16.0),
                      color: Colors.green,
                      child: new Text(
                        'Ya',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'helvetica_neue_light',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    child: new RaisedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(true);
                      },
                      padding: new EdgeInsets.all(16.0),
                      color: Colors.red,
                      child: new Text(
                        'Tidak',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'helvetica_neue_light',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  Future<List<Transaksibelipaket>> transaksiOnProses() async {
    List<Transaksibelipaket> arrTrans = new List();
    Map paramData = {'user': session.userlogin};
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/paketOnProses",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      var data = json.decode(res.body);
      data = data[0]['transaksi'];
      for (int i = 0; i < data.length; i++) {
        Transaksibelipaket databaru = Transaksibelipaket(
            data[i]['id'].toString(),
            data[i]['idpaket'].toString(),
            data[i]['iduser'].toString(),
            data[i]['tanggalbeli'].toString(),
            data[i]['tanggalaktifasi'].toString(),
            data[i]['tanggalselesai'].toString(),
            data[i]['keterangan'].toString(),
            data[i]['durasi'].toString(),
            data[i]['totalharga'].toString(),
            data[i]['status'].toString(),
            data[i]['nama_paket'].toString(),
            data[i]['nama'].toString());
        arrTrans.add(databaru);
      }
      setState(() => this.onProses = arrTrans);
      return arrTrans;
    }).catchError((err) {
      print(err);
    });
  }

  Future<List<Transaksibelipaket>> getTransaksiSelesai() async {
    List<Transaksibelipaket> arrTrans = new List();
    Map paramData = {'user': session.userlogin};
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/getTransaksiSelesai",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      var data = json.decode(res.body);
      data = data[0]['transaksi'];
      for (int i = 0; i < data.length; i++) {
        Transaksibelipaket databaru = Transaksibelipaket(
            data[i]['id'].toString(),
            data[i]['idpaket'].toString(),
            data[i]['iduser'].toString(),
            data[i]['tanggalbeli'].toString(),
            data[i]['tanggalaktifasi'].toString(),
            data[i]['tanggalselesai'].toString(),
            data[i]['keterangan'].toString(),
            data[i]['durasi'].toString(),
            data[i]['totalharga'].toString(),
            data[i]['status'].toString(),
            data[i]['nama_paket'].toString(),
            data[i]['nama'].toString());
        arrTrans.add(databaru);
      }
      setState(() => this.selesai = arrTrans);
      return arrTrans;
    }).catchError((err) {
      print(err);
    });
  }

  Future<List<Transaksibelipaket>> getTransaksiBatal() async {
    List<Transaksibelipaket> arrTrans = new List();
    Map paramData = {'user': session.userlogin};
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/getTransaksiBatal",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      var data = json.decode(res.body);
      data = data[0]['transaksi'];
      for (int i = 0; i < data.length; i++) {
        Transaksibelipaket databaru = Transaksibelipaket(
            data[i]['id'].toString(),
            data[i]['idpaket'].toString(),
            data[i]['iduser'].toString(),
            data[i]['tanggalbeli'].toString(),
            data[i]['tanggalaktifasi'].toString(),
            data[i]['tanggalselesai'].toString(),
            data[i]['keterangan'].toString(),
            data[i]['durasi'].toString(),
            data[i]['totalharga'].toString(),
            data[i]['status'].toString(),
            data[i]['nama_paket'].toString(),
            data[i]['nama'].toString());
        arrTrans.add(databaru);
      }
      setState(() => this.batal = arrTrans);
      return arrTrans;
    }).catchError((err) {
      print(err);
    });
  }

  Future<String> aktivasiPaket(String id, String paket) async {
    print("id = " + id + " paket = " + paket);
    Map paramData = {
      'id': id,
      'paket': paket,
      'username': session.userlogin,
      'berat': session.berat
    };
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/aktivasiPaket",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      // print(res.body);
      var data = json.decode(res.body);
      data = data[0]['transaksi'];
      print("transaksi = " + data.toString());
      getTransaksiBelumSelesai();
      transaksiOnProses();
      getTransaksiSelesai();
      getTransaksiBatal();
      return "selesai";
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Transaksi Page"),
        backgroundColor: session.warna,
      ),
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
                child: AppBar(
                  backgroundColor: session.warna,
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        text: "MyPaket",
                      ),
                      Tab(
                        text: "Proses",
                      ),
                      Tab(
                        text: "Selesai",
                      ),
                      Tab(
                        text: "Batal",
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(
                      child: new ListView.builder(
                          itemCount: arrTransaksi.length == 0
                              ? 0
                              : arrTransaksi.length,
                          itemBuilder: (context, index) {
                            if (arrTransaksi.length == 0) {
                              return Card(
                                child: Text("Data empty"),
                              );
                            } else {
                              return GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                      child: Column(
                                    children: [
                                      Container(
                                        child: Text("Paket " +
                                            arrTransaksi[index].idpaket),
                                      ),
                                      DateTime.parse(arrTransaksi[index]
                                                      .tanggalbeli)
                                                  .add(new Duration(days: 3))
                                                  .compareTo(tglnow) >
                                              0
                                          ? Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 10, 0, 10),
                                                    child: Image.asset(
                                                        'assets/images/waiting.png'),
                                                  ),
                                                  SizedBox(width: 30),
                                                  Container(
                                                    child: RaisedButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                      ),
                                                      onPressed: () {
                                                        showAlert(
                                                            arrTransaksi[index]
                                                                .id,
                                                            arrTransaksi[index]
                                                                .idpaket);
                                                      },
                                                      color: Colors
                                                          .lightBlueAccent,
                                                      child: Text(
                                                        'Aktivasi Paket',
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Container(
                                                    child: RaisedButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                      ),
                                                      onPressed: () {
                                                        print("batal");
                                                      },
                                                      color: Colors
                                                          .lightBlueAccent,
                                                      child: Text(
                                                        'Batal Beli Paket',
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 150),
                                                  Container(
                                                    child: RaisedButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                      ),
                                                      onPressed: () {
                                                        aktivasiPaket(
                                                            arrTransaksi[index]
                                                                .id,
                                                            arrTransaksi[index]
                                                                .idpaket);
                                                      },
                                                      color: Colors
                                                          .lightBlueAccent,
                                                      child: Text(
                                                        'Aktivasi Paket',
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                    ],
                                  )));
                            }
                          }),
                    ),
                    Container(
                      child: new ListView.builder(
                          itemCount: onProses.length == 0 ? 0 : onProses.length,
                          itemBuilder: (context, index) {
                            if (onProses.length == 0) {
                              return Card(
                                child: Text("Data empty"),
                              );
                            } else {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AwalPaket(
                                                id: onProses[index].id,
                                                paket:
                                                    onProses[index].idpaket)));
                                  },
                                  child: Card(
                                      child: Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 0, 10),
                                          child: Image.asset(
                                              'assets/images/progress.png')),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                                child: Text(
                                              onProses[index].namapaket,
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            )),
                                            Container(
                                                child: Text(onProses[index]
                                                    .namakonsultan))
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 50),
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                                child: Text(
                                              "Tanggal Selesai",
                                              style: TextStyle(
                                                fontSize: 10,
                                              ),
                                            )),
                                            Container(
                                                child: Text(onProses[index]
                                                    .tanggalselesai))
                                          ],
                                        ),
                                      ),
                                    ],
                                  )));
                            }
                          }),
                    ),
                    Container(
                      child: new ListView.builder(
                          itemCount: selesai.length == 0 ? 0 : selesai.length,
                          itemBuilder: (context, index) {
                            if (selesai.length == 0) {
                              return Card(
                                child: Text("Data empty"),
                              );
                            } else {
                              return GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                      child: Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 0, 10),
                                          child: Image.asset(
                                              'assets/images/done.png')),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                                child: Text(
                                              selesai[index].namapaket,
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            )),
                                            Container(
                                                child: Text(selesai[index]
                                                    .namakonsultan))
                                          ],
                                        ),
                                      ),
                                    ],
                                  )));
                            }
                          }),
                    ),
                    Container(
                      child: new ListView.builder(
                          itemCount: batal.length == 0 ? 0 : batal.length,
                          itemBuilder: (context, index) {
                            if (batal.length == 0) {
                              return Card(
                                child: Text("Data empty"),
                              );
                            } else {
                              return GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                      child: Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 0, 10),
                                          child: Image.asset(
                                              'assets/images/cancel.png')),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                                child: Text(
                                              batal[index].namapaket,
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            )),
                                            Container(
                                                child: Text(
                                                    batal[index].namakonsultan))
                                          ],
                                        ),
                                      ),
                                    ],
                                  )));
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
