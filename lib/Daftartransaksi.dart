import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Daftartransaksi extends StatefulWidget {
  @override
  DaftartransaksiState createState() => DaftartransaksiState();
}

class DaftartransaksiState extends State<Daftartransaksi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Transaksi Page"),
      ),
      body: Center(),
    );
  }
}
