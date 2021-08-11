import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'ClassUser.dart';
import 'ClassBank.dart';

class Topup extends StatefulWidget {
  @override
  TopupState createState() => TopupState();
}

class TopupState extends State<Topup> {
  TextEditingController saldo = new TextEditingController();
  List<ClassBank> arrBank = new List();
  ClassBank bankyangdipilih = null;

  ClassUser userprofile = new ClassUser(
      "", "", "", "", "", "", "", "", "", "", "", "", "0", "", "");

  void initState() {
    super.initState();
    getProfile();
    arrBank.add(new ClassBank("BNI", "norek", "assets/images/bni.jpg"));
    arrBank.add(new ClassBank("BCA", "norek", "assets/images/bca.png"));
    arrBank.add(
        new ClassBank("Bank Mandiri", "norek", "assets/images/mandiri.png"));
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
              child: DropdownButton<ClassBank>(
                style: Theme.of(context).textTheme.title,
                hint: Text("Pilih Bank"),
                value: bankyangdipilih,
                onChanged: (ClassBank Value) {
                  setState(() {
                    bankyangdipilih = Value;
                  });
                },
                items: arrBank.map((ClassBank bank) {
                  return DropdownMenuItem<ClassBank>(
                    value: bank,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset(
                              bank.foto,
                              fit: BoxFit.contain,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        new Text(bank.nama)
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
