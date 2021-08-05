import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class DetailProdukKonsultan extends StatefulWidget {
  final String id;

  DetailProdukKonsultan({Key key, @required this.id}) : super(key: key);

  @override
  DetailProdukKonsultanState createState() =>
      DetailProdukKonsultanState(this.id);
}

class DetailProdukKonsultanState extends State<DetailProdukKonsultan> {
  String id;

  DetailProdukKonsultanState(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Produk"),
      ),
      body: Center(),
    );
  }
}
