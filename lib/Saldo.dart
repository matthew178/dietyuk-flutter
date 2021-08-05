import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Saldo extends StatefulWidget {
  @override
  SaldoState createState() => SaldoState();
}

class SaldoState extends State<Saldo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History Saldo"),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/topup");
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue.shade200,
      ),
    );
  }
}
