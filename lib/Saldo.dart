import 'package:fluttertoast/fluttertoast.dart';

import 'ClassUser.dart';
import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class Saldo extends StatefulWidget {
  @override
  SaldoState createState() => SaldoState();
}

class SaldoState extends State<Saldo> {
  String foto = session.ipnumber + "/gambar/wanita.png";
  ClassUser userprofile = new ClassUser(
      "", "", "", "", "", "", "", "", "", "", "", "0", "0", "", "");
  NumberFormat frmt = new NumberFormat(",000");

  void initState() {
    super.initState();
    getProfile();
  }

  Future<ClassUser> getProfile() async {
    ClassUser userlog = new ClassUser(
        "", "", "", "", "", "", "", "", "", "", "", "0", "0", "", "");
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
      print("foto : " + userprofile.foto);
      if (userprofile.jeniskelamin == "pria" && userprofile.foto == "pria.png")
        foto = session.ipnumber + "/gambar/pria.jpg";
      else if (userprofile.jeniskelamin == "wanita" &&
          userprofile.foto == "wanita.png")
        foto = session.ipnumber + "/gambar/wanita.png";
      else
        foto = session.ipnumber + "/gambar/" + userprofile.foto;
      return userlog;
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 81, 158, 1),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      int.parse(userprofile.saldo.toString()) > 1000
                          ? Text(
                              'Rp. ' +
                                  frmt.format(
                                      int.parse(userprofile.saldo.toString())),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700),
                            )
                          : Text(
                              'Rp. ' + userprofile.saldo.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700),
                            ),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(width: 20),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image.network(
                                  session.ipnumber + "/gambar/wanita.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Saldo",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.blue[100]),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/topup");
                                },
                                icon: Icon(
                                  Icons.trending_down,
                                  color: Colors.blue[900],
                                  size: 30,
                                )),
                            padding: EdgeInsets.all(12),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Tambah Saldo",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.blue[100]),
                          )
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.attach_money,
                                color: Colors.blue[900],
                                size: 30,
                              ),
                            ),
                            padding: EdgeInsets.all(12),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Tarik Saldo",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.blue[100]),
                          )
                        ],
                      )),
                    ],
                  )
                ],
              ),
            ),
            DraggableScrollableSheet(builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 245, 248, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "History Transaksi",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                  color: Colors.black),
                            ),
                            Text(
                              "Lihat Semua",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.grey[800]),
                            )
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),
                      SizedBox(height: 24),
                      // Container(
                      //   child: Text("Semua"),
                      // )
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
