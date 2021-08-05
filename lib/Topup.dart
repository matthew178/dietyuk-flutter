import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'ClassUser.dart';

class Topup extends StatefulWidget {
  @override
  TopupState createState() => TopupState();
}

class TopupState extends State<Topup> {
  TextEditingController saldo = new TextEditingController();
  String bankygdipilih = "BNI";

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
          data[0]["foto"].toString());
      setState(() => this.userprofile = userlog);
      return userlog;
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top up Saldo"),
      ),
      body: Center(
        child: ListView(
          children: [
            Expanded(
              flex: 1,
              child: DropdownButton<String>(
                style: Theme.of(context).textTheme.title,
                hint: Text("Pilih Bank"),
                value: bankygdipilih,
                onChanged: (String Value) {
                  setState(() {
                    bankygdipilih = Value;
                  });
                },
                items:
                    <String>['BNI', 'BRI', 'Mandiri', 'BCA'].map((String bank) {
                  return DropdownMenuItem<String>(
                    value: bank,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          bank,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
