import 'package:dietyuk/Daftartransaksimember.dart';
import 'package:dietyuk/HomepageMember.dart';
import 'package:flutter/material.dart';
import 'Myprofile.dart';

class Dashmember extends StatefulWidget {
  @override
  DashmemberState createState() => DashmemberState();
}

class DashmemberState extends State<Dashmember> {
  int index = 0;

  final bottomBar = [
    HomePageMember(),
    Daftartransaksimember(),
    Myprofile()
  ]; //harusnya homepage, chat, profile

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
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat), title: Text("Kotak Masuk")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_outlined), title: Text("My Profile"))
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: _onTapItem,
      ),
    );
  }
}
