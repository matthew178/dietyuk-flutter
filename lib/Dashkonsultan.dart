import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'DaftarPaketKonsultan.dart';
import 'Daftartransaksi.dart';
import 'Myprofile.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'session.dart';
import 'DaftarProduk.dart';

class Dashkonsultan extends StatefulWidget {
  @override
  DashkonsultanState createState() => DashkonsultanState();
}

class DashkonsultanState extends State<Dashkonsultan> {
  int index = 0;

  final bottomBar = [
    Daftarpaketkonsultan(),
    DaftarProduk(),
    Daftartransaksi(),
    Myprofile()
  ];

  void _onTapItem(int idx) {
    setState(() {
      index = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomBar.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text("Paket")),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), title: Text("Produk")),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_grocery_store),
              title: Text("Order")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_outlined), title: Text("Profile"))
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: _onTapItem,
      ),
    );
  }
}
