import 'package:dietyuk/session.dart';
import 'package:dietyuk/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'session.dart' as session;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController myUsername = new TextEditingController();
  TextEditingController myPassword = new TextEditingController();
  SharedPreferences preference;
  String user = "0", role = "", berat = "0";
  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    preference = await SharedPreferences.getInstance();
    user = preference.getString("user") ?? "0";
    role = preference.getString("role") ?? "";
    berat = preference.getString("berat") ?? "0";
    session.userlogin = int.parse(user);
    session.role = role;
    session.berat = int.parse(berat);
    if (role != "") {
      if (role == "member") {
        var temp = jsonDecode(
            preference.getString('cart ' + session.userlogin.toString()) ??
                "[]");
        for (var i = 0; i < temp.length; i++) {
          session.Cart.add(new shoppingcart(
              temp[i]["kodeproduk"].toString(),
              temp[i]["username"].toString(),
              temp[i]["jumlah"].toString(),
              temp[i]["konsultan"].toString(),
              temp[i]["harga"].toString()));
        }
        Navigator.of(this.context).pushNamedAndRemoveUntil(
            '/member', (Route<dynamic> route) => false);
      } else if (role == "konsultan") {
        Navigator.of(this.context).pushNamedAndRemoveUntil(
            '/konsultan', (Route<dynamic> route) => false);
      }
    }
  }

  Future<String> evtLogin() async {
    preference = await SharedPreferences.getInstance();
    Map paramData = {
      'username': myUsername.text,
      'password': myPassword.text,
    };
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/login",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      print("hasil = " + res.body);
      if (res.body.contains("sukses")) {
        var data = json.decode(res.body);
        session.userlogin = data[0]['id'];
        session.role = data[0]['role'];
        Fluttertoast.showToast(msg: "Berhasil Login");
        preference.setString("user", data[0]['id'].toString());
        preference.setString("role", data[0]['role']);
        preference.setString("berat", data[0]['berat']);

        if (data[0]['role'] == "member") {
          var temp = jsonDecode(
              preference.getString('cart ' + session.userlogin.toString()) ??
                  "[]");
          for (var i = 0; i < temp.length; i++) {
            session.Cart.add(new shoppingcart(
                temp[i]["kodeproduk"].toString(),
                temp[i]["username"].toString(),
                temp[i]["jumlah"].toString(),
                temp[i]["konsultan"].toString(),
                temp[i]["harga"].toString()));
          }
          Navigator.pushNamed(this.context, "/member");
        } else if (data[0]['role'] == "konsultan") {
          Navigator.pushNamed(this.context, "/konsultan");
        }
      } else {
        Fluttertoast.showToast(msg: "Gagal Login");
      }
    }).catchError((err) {
      print(err);
    });
    return "";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ShaderMask(
            shaderCallback: (rect) => LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [Colors.black, Colors.transparent]).createShader(rect),
            blendMode: BlendMode.darken,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/loginpage.png'),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black54, BlendMode.darken))),
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Flexible(
                  child: Center(
                      child: Text(
                'Dietyuk!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold),
              ))),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                    height: size.height * 0.08,
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.grey[500].withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: TextField(
                        controller: myUsername,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.person,
                                size: 28,
                                color: kWhite,
                              ),
                            ),
                            hintText: "Nama Pengguna",
                            hintStyle: kBodyText),
                        style: kBodyText,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                    height: size.height * 0.08,
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.grey[500].withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: TextField(
                        controller: myPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.lock,
                                size: 28,
                                color: kWhite,
                              ),
                            ),
                            hintText: "Kata Sandi",
                            hintStyle: kBodyText),
                        style: kBodyText,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      ),
                    )),
              ),
              SizedBox(height: 25),
              Container(
                height: size.height * 0.08,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16), color: kBlue),
                child: FlatButton(
                  onPressed: () {
                    evtLogin();
                  },
                  child: Text(
                    'Masuk',
                    style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/register'),
                child: Container(
                  child: Text(
                    'Buat Akun Baru',
                    style: kBodyText,
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(width: 1, color: kWhite))),
                ),
              ),
              SizedBox(height: 25)
            ],
          ),
        )
      ],
    );
  }
}
