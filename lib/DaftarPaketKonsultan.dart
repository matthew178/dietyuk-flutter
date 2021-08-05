import 'package:dietyuk/ClassPaket.dart';
import 'package:dietyuk/DetailPaket.dart';
import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'ClassPaket.dart';
import 'DetailPaketKonsultan.dart';
import 'EditJadwalPaket.dart';

class Daftarpaketkonsultan extends StatefulWidget {
  @override
  DaftarpaketkonsultanState createState() => DaftarpaketkonsultanState();
}

class DaftarpaketkonsultanState extends State<Daftarpaketkonsultan> {
  List<ClassPaket> arrPaket = new List();
  @override
  void initState() {
    super.initState();
    getPaket();
  }

  Future<List<ClassPaket>> getPaket() async {
    List<ClassPaket> arrPaket = new List();
    Map paramData = {'id': session.userlogin};
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/getpaketkonsultan",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
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
            data[i]['gambar'].toString());
        arrPaket.add(databaru);
      }
      setState(() => this.arrPaket = arrPaket);
      print(arrPaket.length);
      return arrPaket;
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: session.warna,
      appBar: AppBar(
        title: Text("Daftar Paket Page"),
      ),
      body: new ListView.builder(
          itemCount: arrPaket.length == 0 ? 0 : arrPaket.length,
          itemBuilder: (context, index) {
            if (arrPaket.length == 0) {
              return Card(
                child: Text("Data empty"),
              );
            } else {
              return GestureDetector(
                  onTap: () {},
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.amber[50],
                      elevation: 4,
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, left: 20.0, right: 20.0),
                          child: Column(
                            children: [
                              Row(children: [
                                Image.asset(
                                  "assets/images/logo.png",
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(width: 20.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Text(
                                          arrPaket[index].nama,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                        child: Text(
                                            arrPaket[index].durasi + " hari",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red))),
                                    Container(
                                        child: Text(
                                            "Rp. " +
                                                arrPaket[index]
                                                    .harga
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black))),
                                  ],
                                )
                              ]),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailPaketKonsultan(
                                                            id: arrPaket[index]
                                                                .id)));
                                          },
                                          color: Colors.lightBlueAccent,
                                          child: Text(
                                            'Edit Info Paket',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditJadwalPaket(
                                                            id: arrPaket[index]
                                                                .id)));
                                          },
                                          color: Colors.lightBlueAccent,
                                          child: Text(
                                            'Edit Jadwal Paket',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ))));
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/tambahpaket");
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue.shade200,
      ),
    );
  }
}
