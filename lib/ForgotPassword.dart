import 'package:hexcolor/hexcolor.dart';

import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ForgotPassword extends StatefulWidget {
  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController otp = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController konfir = new TextEditingController();
  TextEditingController username = new TextEditingController();
  int mode = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // ShaderMask(
        //     shaderCallback: (rect) => LinearGradient(
        //         begin: Alignment.bottomCenter,
        //         end: Alignment.center,
        //         colors: [Colors.black, Colors.transparent]).createShader(rect),
        //     blendMode: BlendMode.darken,
        //     child: Container(
        //       decoration: BoxDecoration(
        //           image: DecorationImage(
        //               image: AssetImage('assets/images/registerpage.png'),
        //               fit: BoxFit.cover,
        //               colorFilter:
        //                   ColorFilter.mode(Colors.black54, BlendMode.darken))),
        //     )),
        Scaffold(
          backgroundColor: session.warna,
          body: ListView(
            children: [
              // SizedBox(height: size.height * 0.1),
              Center(
                  child: Center(
                      child: Text(
                '',
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
                    height: size.height * 0.5,
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        // color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                        child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.1, 0, size.width * 0.1, 0),
                          child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: TextField(
                                  controller: username,
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
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: TextField(
                                  controller: otp,
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
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: TextField(
                                  controller: pass,
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
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                child: TextField(
                                  controller: konfir,
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
                      ],
                    ))),
              ),
              SizedBox(height: 10),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(
              //       size.width * 0.1, 0, size.width * 0.1, 0),
              //   child: Container(
              //       height: size.height * 0.08,
              //       width: size.width * 0.8,
              //       child: Center(
              //         child: Container(
              //           height: size.height * 0.08,
              //           width: size.width * 0.8,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(16),
              //               color: session.kBlue),
              //           child: FlatButton(
              //             onPressed: () {
              //               evtRegister();
              //             },
              //             child: Text(
              //               'Daftar',
              //               style: session.kBodyText
              //                   .copyWith(fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //         ),
              //       )),
              // ),
              SizedBox(height: 5),
            ],
          ),
        )
      ],
    );
  }
}
