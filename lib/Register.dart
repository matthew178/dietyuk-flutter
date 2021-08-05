import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'Provinsi.dart';
import 'Kota.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  TextEditingController myUsername = new TextEditingController();
  TextEditingController myName = new TextEditingController();
  TextEditingController myEmail = new TextEditingController();
  TextEditingController myNumber = new TextEditingController();
  TextEditingController myPassword = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  List<Provinsi> arrProvinsi = new List();
  List<Kota> arrKota = new List();
  bool status = false;
  String jk = "pria";

  Future<String> evtRegister() async {
    Map paramData = {
      'username': myUsername.text,
      'password': myPassword.text,
      'cpassword': confirmPassword.text,
      'email': myEmail.text,
      'nohp': myNumber.text,
      'konsultan': status,
      'nama': myName.text,
      'jk': jk
    };
    var parameter = json.encode(paramData);
    if (myPassword.text == confirmPassword.text) {
      http
          .post(session.ipnumber + "/register",
              headers: {"Content-Type": "application/json"}, body: parameter)
          .then((res) {
        print(res.body);
      }).catchError((err) {
        print(err);
      });
    }
    return "";
  }

  void initState() {
    super.initState();
    setState(() {
      this.jk = "pria";
    });
    // getProvinsi();
  }

  Future<List<Provinsi>> getProvinsi() async {
    List<Provinsi> tempProvinsi = new List();
    Provinsi prv = new Provinsi("1", "");
    http.get("https://api.rajaongkir.com/starter/province", headers: {
      "Content-Type": "application/json",
      "key": "08989a3df11fde8300acd691159a2ebd"
    }).then((res) {
      var data = json.decode(res.body);
      data = data['rajaongkir']['results'];
      for (int i = 0; i < data.length; i++) {
        prv = new Provinsi(data[i]['province_id'], data[i]['province']);
        tempProvinsi.add(prv);
      }
      setState(() {
        this.arrProvinsi = tempProvinsi;
      });
    }).catchError((err) {
      print(err);
    });
    return tempProvinsi;
  }

  Future<String> getKota(String provinsi) async {
    Map paramData = {'province': provinsi};
    var parameter = json.encode(paramData);
    if (myPassword.text == confirmPassword.text) {
      http
          .post(session.ipnumber + "/register",
              headers: {"Content-Type": "application/json"}, body: parameter)
          .then((res) {
        print(res.body);
      }).catchError((err) {
        print(err);
      });
    }
    return "";
  }

  void handleradiogroup(String value) {
    setState(() => this.jk = value);
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
                      image: AssetImage('assets/images/registerpage.png'),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black54, BlendMode.darken))),
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              // SizedBox(height: size.height * 0.1),
              Center(
                  child: Center(
                      child: Text(
                'Buat Akun Baru',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ))),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.1, 0, size.width * 0.1, 0),
                child: Container(
                    height: size.height * 0.8,
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.grey[500].withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                        child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.1, 20, size.width * 0.1, 10),
                          child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.grey[500].withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: TextField(
                                  controller: myName,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                      ),
                                      hintText: "Nama",
                                      hintStyle: session.kBodyText),
                                  style: session.kBodyText,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.1, 0, size.width * 0.1, 0),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                      ),
                                      hintText: "Username",
                                      hintStyle: session.kBodyText),
                                  style: session.kBodyText,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.1, 10, size.width * 0.1, 0),
                          child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.grey[500].withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: TextField(
                                  controller: myEmail,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                      ),
                                      hintText: "Email",
                                      hintStyle: session.kBodyText),
                                  style: session.kBodyText,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.done,
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.1, 10, size.width * 0.1, 0),
                          child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.grey[500].withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          child: Center(
                                            child: Radio(
                                              activeColor: Colors.green,
                                              value: "pria",
                                              groupValue: jk,
                                              onChanged: handleradiogroup,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          child: Center(
                                            child: Text(
                                              "Pria",
                                              style: session.kradioButton,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          child: Center(
                                            child: Radio(
                                              activeColor: Colors.green,
                                              value: "wanita",
                                              groupValue: jk,
                                              onChanged: handleradiogroup,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          child: Center(
                                            child: Text(
                                              "Wanita",
                                              style: session.kradioButton,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.1, 10, size.width * 0.1, 0),
                          child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.grey[500].withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: TextField(
                                  controller: myNumber,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                      ),
                                      hintText: "Nomor Telepon",
                                      hintStyle: session.kBodyText),
                                  style: session.kBodyText,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.1, 10, size.width * 0.1, 0),
                          child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.grey[500].withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: TextField(
                                  controller: myPassword,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                      ),
                                      hintText: "Kata Sandi",
                                      hintStyle: session.kBodyText),
                                  style: session.kBodyText,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.1, 10, size.width * 0.1, 0),
                          child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.grey[500].withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: TextField(
                                  controller: confirmPassword,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                      ),
                                      hintText: "Konfirmasi Kata Sandi",
                                      hintStyle: session.kBodyText),
                                  style: session.kBodyText,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.1, 10, size.width * 0.1, 0),
                          child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.grey[500].withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                  child: CheckboxListTile(
                                value: status,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text(
                                  "Konsultan",
                                  style: session.kBodyText,
                                ),
                                onChanged: (bool Value) {
                                  if (status == true) {
                                    setState(() {
                                      status = false;
                                    });
                                  } else {
                                    setState(() {
                                      status = true;
                                    });
                                  }
                                },
                              ))),
                        ),
                      ],
                    ))),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.1, 0, size.width * 0.1, 0),
                child: Container(
                    height: size.height * 0.08,
                    width: size.width * 0.8,
                    child: Center(
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: session.kBlue),
                        child: FlatButton(
                          onPressed: () {
                            evtRegister();
                          },
                          child: Text(
                            'Daftar',
                            style: session.kBodyText
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.1, 10, size.width * 0.1, 0),
                child: Container(
                    height: size.height * 0.08,
                    width: size.width * 0.8,
                    child: Center(
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/'),
                        child: Container(
                          child: Text(
                            'Kembali Ke Halaman Awal',
                            style: session.kBodyText,
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: session.kWhite))),
                        ),
                      ),
                    )),
              ),
              SizedBox(height: 25)
            ],
          ),
        )
      ],
    );
  }
}
