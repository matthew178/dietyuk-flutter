import 'package:dietyuk/ClassPerkembangan.dart';
import 'package:dietyuk/JadwalHarian.dart';

import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ClassPaket.dart';
import 'dart:async';
import 'dart:convert';
import 'ClassDetailPaket.dart';

class AwalPaket extends StatefulWidget {
  final String id;
  final String paket;

  AwalPaket({Key key, @required this.id, @required this.paket})
      : super(key: key);

  @override
  AwalPaketState createState() => AwalPaketState(this.id, this.paket);
}

class AwalPaketState extends State<AwalPaket> {
  String week = "1";
  ClassPaket paketsekarang = new ClassPaket("id", "estimasi", "0", "durasi",
      "status", "", "konsultan", "namapaket1", "deskripsi", "default.jpg");
  String id, paket;
  List<DetailBeli> detail = new List();
  List<DetailBeli> tempDetail = new List();
  List<ClassPerkembangan> arrLaporan = new List();
  int durasi = 5;

  AwalPaketState(this.id, this.paket);

  @override
  void initState() {
    super.initState();
    getPaket();
    getDetail();
    getLaporan();
  }

  Future<List<ClassPerkembangan>> getLaporan() async {
    List<ClassPerkembangan> tempLaporan = List();
    Map paramData = {'idbeli': id};
    var parameter = json.encode(paramData);
    ClassPerkembangan databaru = new ClassPerkembangan(
        "id", "idbeli", "username", "berat", "status", "harike");
    http
        .post(session.ipnumber + "/getlaporanperkembangan",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      var data = json.decode(res.body);
      data = data[0]['laporan'];
      for (int i = 0; i < data.length; i++) {
        databaru = ClassPerkembangan(
            data[0]['id'].toString(),
            data[0]['idbeli'].toString(),
            data[0]['username'].toString(),
            data[0]['berat'].toString(),
            data[0]['status'].toString(),
            data[0]['harike'].toString());
        tempLaporan.add(databaru);
      }
      setState(() => this.arrLaporan = tempLaporan);
      return tempLaporan;
    }).catchError((err) {
      print(err);
    });
  }

  Future<List<DetailBeli>> getDetail() async {
    List<DetailBeli> arrDetail = new List();
    Map paramData = {'id': id};
    var parameter = json.encode(paramData);
    DetailBeli databaru = new DetailBeli("id", "hari", "tanggal", "week");
    int week = 0;
    http
        .post(session.ipnumber + "/getdetailbeli",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      var data = json.decode(res.body);
      data = data[0]['detail'];
      for (int i = 0; i < data.length; i++) {
        week = ((int.parse(data[i]['hari'].toString()) - 1) ~/ 7).toInt() + 1;
        databaru = DetailBeli("0", data[i]['hari'].toString(),
            data[i]['tanggal'].toString(), week.toString());
        arrDetail.add(databaru);
      }
      setState(() => this.detail = arrDetail);
      sesuaikanHari(1);
      return arrDetail;
    }).catchError((err) {
      print(err);
    });
  }

  Future<List<DetailBeli>> sesuaikanHari(int week) async {
    List<DetailBeli> tempDetail = new List();
    DetailBeli databaru = new DetailBeli("id", "id_paket", "hari", "waktu");
    for (int i = 0; i < detail.length; i++) {
      if (detail[i].week == week.toString()) {
        databaru = DetailBeli(
            detail[i].id, detail[i].hari, detail[i].tanggal, detail[i].week);
        tempDetail.add(databaru);
      }
    }
    setState(() => this.tempDetail = tempDetail);
    return tempDetail;
  }

  Future<ClassPaket> getPaket() async {
    ClassPaket arrPaket = new ClassPaket(
        "id",
        "estimasi",
        "harga",
        "durasi",
        "status",
        "rating",
        "konsultan",
        "namapaket",
        "deskripsi",
        "default.jpg");
    Map paramData = {'id': paket};
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/getpaketbyid",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      var data = json.decode(res.body);
      data = data[0]['paket'];
      arrPaket = ClassPaket(
          data[0]['id_paket'].toString(),
          data[0]['estimasiturun'].toString(),
          data[0]['harga'].toString(),
          data[0]['durasi'].toString(),
          data[0]['status'].toString(),
          data[0]['rating'].toString(),
          data[0]['nama'].toString(),
          data[0]['nama_paket'].toString(),
          data[0]['deskripsi'].toString(),
          data[0]['gambar'].toString());
      if (int.parse(data[0]['durasi'].toString()) % 7 == 0) {
        durasi = int.parse(data[0]['durasi'].toString()) ~/ 7;
      } else {
        durasi = int.parse(data[0]['durasi'].toString()) ~/ 7 + 1;
      }
      setState(() => this.paketsekarang = arrPaket);
      return arrPaket;
    }).catchError((err) {
      print(err);
    });
  }

  Future<void> evtSebelum() async {
    if (int.parse(week) <= 1) {
      setState(() {
        week = durasi.toString();
      });
    } else {
      setState(() {
        week = (int.parse(week) - 1).toString();
      });
    }
    sesuaikanHari(int.parse(week));
  }

  Future<void> evtSesudah() async {
    if (int.parse(week) >= durasi) {
      setState(() {
        week = "1";
      });
    } else {
      setState(() {
        week = (int.parse(week) + 1).toString();
      });
    }
    sesuaikanHari(int.parse(week));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Program Diet"),
        backgroundColor: session.warna,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        onPressed: () {
                          evtSebelum();
                        },
                        color: Colors.lightBlueAccent,
                        child: Text(
                          '<',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          "Minggu " + week.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontFamily: 'Biryani'),
                        )),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        onPressed: () {
                          evtSesudah();
                        },
                        color: Colors.lightBlueAccent,
                        child: Text(
                          '>',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Image.asset(
                "assets/images/awalpage.png",
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                flex: 5,
                child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    children: List.generate(tempDetail.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JadwalHarian(
                                      week: week,
                                      idbeli: id,
                                      hari: tempDetail[index].hari)));
                        },
                        child: Card(
                            color: Colors.grey,
                            elevation: 10.0,
                            child: Center(
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Hari " + tempDetail[index].hari,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Biryani'),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        tempDetail[index].tanggal,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Biryani'),
                                      ))
                                ],
                              ),
                            )),
                      );
                    })))
          ],
        ),
      ),
    );
  }
}
