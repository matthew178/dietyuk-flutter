import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Tambahpaket extends StatefulWidget {
  @override
  TambahpaketState createState() => TambahpaketState();
}

class TambahpaketState extends State<Tambahpaket> {
  TextEditingController namaPaket = new TextEditingController();
  TextEditingController descPaket = new TextEditingController();
  TextEditingController estimasi = new TextEditingController();
  TextEditingController harga = new TextEditingController();
  TextEditingController durasi = new TextEditingController();

  Future<String> tambahPaket() async {
    Map paramData = {
      'nama': namaPaket.text,
      'desc': descPaket.text,
      'estimasi': estimasi.text,
      'harga': harga.text,
      'durasi': durasi.text,
      'konsultan': session.userlogin
    };
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/tambahpaket",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      print(res.body);
      Navigator.pushNamed(context, "/konsultan");
    }).catchError((err) {
      print(err);
    });

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Paket Diet"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                child: Center(
                  child: TextFormField(
                    controller: namaPaket,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: "Nama Paket", hintText: "ex. Diet Karbo"),
                    validator: (value) =>
                        value.isEmpty ? "Nama Paket tidak boleh kosong" : null,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                child: Center(
                  child: TextField(
                    controller: descPaket,
                    keyboardType: TextInputType.multiline,
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: "Deskripsi Paket",
                        hintText: "ex. Diet Karbo adalah diet yang tidak  "),
                    maxLines: null,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                child: Center(
                  child: TextFormField(
                    controller: estimasi,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: "Estimasi Turun (Kg)", hintText: ""),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                child: Center(
                  child: TextFormField(
                    controller: harga,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: InputDecoration(labelText: "Harga (Rp)"),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                child: Center(
                  child: TextFormField(
                    controller: durasi,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: InputDecoration(labelText: "Durasi (Hari)"),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 30, 10, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    onPressed: () {
                      tambahPaket();
                    },
                    color: Colors.lightBlueAccent,
                    child: Text(
                      'Tambah',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
