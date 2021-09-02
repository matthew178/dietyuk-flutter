import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class TambahLibur extends StatefulWidget {
  @override
  TambahLiburState createState() => TambahLiburState();
}

class TambahLiburState extends State<TambahLibur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Libur Page"),
      ),
      body: Center(),
    );
  }
}
