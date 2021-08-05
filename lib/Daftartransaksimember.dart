import 'package:dietyuk/AwalPaket.dart';
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
            data[i]['status'].toString());
        arrTrans.add(databaru);
      }
      setState(() => this.arrTransaksi = arrTrans);
      return arrTrans;
    }).catchError((err) {
      print(err);
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
            data[i]['status'].toString());
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
            data[i]['status'].toString());
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
            data[i]['status'].toString());
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
                                                  SizedBox(width: 75),
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
                                                        aktivasiPaket(
                                                            arrTransaksi[index]
                                                                .id,
                                                            arrTransaksi[index]
                                                                .idpaket);
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
                                      child: Column(
                                    children: [
                                      Container(
                                        child: Text(
                                            "Paket " + onProses[index].idpaket),
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
                                      child: Column(
                                    children: [
                                      Container(
                                        child: Text(
                                            "Paket " + selesai[index].idpaket),
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
                                      child: Column(
                                    children: [
                                      Container(
                                        child: Text(
                                            "Paket " + batal[index].idpaket),
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
