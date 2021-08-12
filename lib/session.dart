import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dietyuk/shoppingcart.dart';
import 'package:hexcolor/hexcolor.dart';

String ipnumber = "http://192.168.54.172/dietyuk/public";
int userlogin = 0;
String role = "";
int berat = 0;
int saldo = 0;
List<shoppingcart> Cart = new List();

const TextStyle kBodyText = TextStyle(fontSize: 18, color: Colors.white);
const TextStyle kradioButton = TextStyle(fontSize: 20, color: Colors.white);
const TextStyle cardStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
const Color kWhite = Colors.white;
const Color kBlue = Colors.cyan;
Color warna = HexColor("#81c3d7");
