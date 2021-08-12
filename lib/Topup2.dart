import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'ClassUser.dart';
import 'ClassBank.dart';
import 'package:intl/intl.dart';

class Topup2 extends StatefulWidget {
  final ClassBank bank;
  final String nominal;

  Topup2({Key key, @required this.bank, @required this.nominal})
      : super(key: key);

  @override
  Topup2State createState() => Topup2State(this.bank, this.nominal);
}

class Topup2State extends State<Topup2> {
  // TextEditingController saldo = new TextEditingController();
  NumberFormat frmt = new NumberFormat(",000");
  ClassBank bank;
  String nominal;
  ClassUser userprofile = new ClassUser(
      "", "", "", "", "", "", "", "", "", "", "", "", "0", "", "");

  Topup2State(this.bank, this.nominal);

  void initState() {
    super.initState();
    getProfile();
    print(nominal);
  }

  Future<String> evtTopup() async {
    Map paramData = {'saldo': nominal, 'id': session.userlogin};
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
    return Scaffold(
      appBar: AppBar(
        title: Text("TOP UP SALDO"),
        backgroundColor: session.warna,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 30),
              Container(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Icon(
                          AntDesign.wallet,
                          color: Colors.blue[900],
                          size: 50,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          "Disarankan untuk menghindari top up antara pukul 21.00 s/d 03.00 dikarenakan adanya cut off mutasi internet banking sehingga proses validasi pembayaran memerlukan waktu yang lama.",
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 250,
                width: 375,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Container(
                        child: Text(
                      "> Silahkan Transfer dengan detail berikut :",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    )),
                    SizedBox(height: 5),
                    Container(
                      child: Text("Bank " + bank.nama + " : " + bank.norek,
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700])),
                    ),
                    Container(
                      child: Text(
                          "Nominal : Rp. " +
                              frmt.format(int.parse(nominal.toString())),
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700])),
                    ),
                    Container(
                      child: Text("Atas Nama " + bank.atasnama,
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700])),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                          "> Saldo anda akan masuk maksimal dalam waktu 30 menit",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700])),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
