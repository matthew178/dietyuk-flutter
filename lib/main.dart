import 'package:dietyuk/Dashkonsultan.dart';
import 'package:dietyuk/Dashmember.dart';
import 'package:dietyuk/Register.dart';
import 'package:dietyuk/checkout.dart';
import 'package:dietyuk/perkembanganmember.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'Login.dart';
import 'Dashkonsultan.dart';
import 'Dashmember.dart';
import 'Tambahpaket.dart';
import 'Editprofile.dart';
import 'Saldo.dart';
import 'Topup.dart';
import 'Topup2.dart';
import 'TambahProduk.dart';
import 'Coba.dart';
import 'Daftarpaket.dart';

void main() {
  runZoned(() {
    runApp(MaterialApp(
      title: 'dietyuk',
      home: MyApp(),
    ));
  }, onError: (dynamic error, dynamic stack) {
    print(error);
    print(stack);
  });
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dietyuk',
      theme: ThemeData(
          textTheme:
              // GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
              GoogleFonts.aBeeZeeTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/register': (context) => Register(),
        '/konsultan': (context) => Dashkonsultan(),
        '/member': (context) => Dashmember(),
        '/tambahpaket': (context) => Tambahpaket(),
        '/editprofile': (context) => Editprofile(),
        '/saldo': (context) => Saldo(),
        '/topup': (context) => Topup(),
        '/tambahproduk': (context) => TambahProduk(),
        '/halamancart': (context) => Checkout()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
  }
}
