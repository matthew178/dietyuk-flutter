import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'ClassUser.dart';

class Topup2 extends StatefulWidget {
  @override
  Topup2State createState() => Topup2State();
}

class Topup2State extends State<Topup2> {
  TextEditingController saldo = new TextEditingController();

  ClassUser userprofile = new ClassUser(
      "", "", "", "", "", "", "", "", "", "", "", "", "0", "", "");

  void initState() {
    super.initState();
    getProfile();
  }

  Future<String> evtTopup() async {
    Map paramData = {'saldo': saldo.text, 'id': session.userlogin};
    var parameter = json.encode(paramData);

    http
        .post(session.ipnumber + "/topup",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      print(res.body);
    }).catchError((err) {
      print(err);
    });
    return "";
  }

  Future<ClassUser> getProfile() async {
    ClassUser userlog = new ClassUser(
        "", "", "", "", "", "", "", "", "", "", "", "", "0", "", "");
    Map paramData = {'id': session.userlogin};
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/getprofile",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      print(res.body);
      var data = json.decode(res.body);
      data = data[0]['profile'];
      userlog = ClassUser(
          data[0]["id"].toString(),
          data[0]["username"].toString(),
          data[0]["email"].toString(),
          data[0]["password"].toString(),
          data[0]["nama"].toString(),
          data[0]["jeniskelamin"].toString(),
          data[0]["nomorhp"].toString(),
          data[0]["tanggallahir"].toString(),
          data[0]["berat"].toString(),
          data[0]["tinggi"].toString(),
          data[0]["role"].toString(),
          data[0]["saldo"].toString(),
          data[0]["rating"].toString(),
          data[0]["status"].toString(),
          data[0]['foto'].toString());
      setState(() => this.userprofile = userlog);
      return userlog;
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    String img = "";
    if (userprofile.jeniskelamin == "pria")
      img = "assets/images/pria.jpg";
    else
      img = "assets/images/wanita.png";
    return Scaffold(
      appBar: AppBar(
        title: Text("Topup2 Saldo"),
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 50),
            Image.asset(
              img,
              width: 150,
              height: 150,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(150, 15, 10, 0),
              child: Text("@" + userprofile.username,
                  style: TextStyle(fontSize: 15, color: Colors.grey)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(75, 10, 10, 0),
              child: Text(userprofile.nama, style: TextStyle(fontSize: 20)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(160, 30, 10, 0),
              child: Text("Saldo", style: TextStyle(fontSize: 15)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(125, 10, 10, 0),
              child: Text("Rp. " + userprofile.saldo,
                  style: TextStyle(fontSize: 20)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 30, 10, 0),
              child: TextFormField(
                controller: saldo,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: InputDecoration(labelText: "Jumlah"),
                validator: (value) =>
                    value.isEmpty ? "Jumlah topup tidak boleh kosong" : null,
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(20, 30, 10, 0),
                child: GestureDetector()),
          ],
        ),
      ),
    );
  }
}
