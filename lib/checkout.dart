import 'package:flutter/material.dart';
import 'package:dietyuk/ClassProduk.dart';
import 'package:dietyuk/shoppingcart.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'shoppingcart.dart';
import 'ProdukDetail.dart';
import 'session.dart' as session;
import 'package:fluttertoast/fluttertoast.dart';

class Checkout extends StatefulWidget {
  @override
  CheckoutState createState() => CheckoutState();
}

class CheckoutState extends State<Checkout> {
  NumberFormat frmt = new NumberFormat(",000");
  // List<ClassProduk> arrProduk = new List();
  List<shoppingcart> cartshop = new List();
  int jumlah = 0;
  int total = 0;
  ClassProduk produk = new ClassProduk(
      "kodeproduk",
      "konsultan",
      "namaproduk",
      "kodekategori",
      "kemasan",
      "0",
      "defaultproduct.png",
      "deskripsi",
      "status",
      "varian",
      "pria.jpg",
      "0");

  void initState() {
    super.initState();
    if (session.Cart.length == 0) {
      print("kosong");
    } else {
      getArrProduk();
      for (int i = 0; i < session.Cart.length; i++) {
        if (session.Cart.length != 0 &&
            int.parse(session.Cart[i].username) == session.userlogin) {
          jumlah++;
          cartshop.add(session.Cart[i]);
        }
      }
    }
  }

  void showAlert(int index) {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 230.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
              child: new Container(
                  child: new Text("Hapus produk ini dari Keranjang ?")),
              flex: 2,
            ),
            new Expanded(
              child: Row(
                children: [
                  SizedBox(width: 30),
                  Container(
                    child: new RaisedButton(
                      onPressed: () {
                        setState(() {
                          session.Cart.removeAt(index);
                          cartshop.removeAt(index);
                          hitungTotal();
                          // arrProduk.removeAt(index);
                        });
                        Fluttertoast.showToast(
                            msg: "Berhasil hapus produk dari Keranjang!");
                        Navigator.of(context, rootNavigator: true).pop(true);
                      },
                      padding: new EdgeInsets.all(16.0),
                      color: Colors.green,
                      child: new Text(
                        'Ya',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'helvetica_neue_light',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    child: new RaisedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(true);
                      },
                      padding: new EdgeInsets.all(16.0),
                      color: Colors.red,
                      child: new Text(
                        'Tidak',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'helvetica_neue_light',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  Future<List<ClassProduk>> getArrProduk() async {
    List<ClassProduk> tempProduk = new List();
    Map paramData = {'id': 'all'};
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/getProdukKategori",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      // print(res.body);
      var data = json.decode(res.body);
      data = data[0]['produk'];
      for (int i = 0; i < data.length; i++) {
        for (int j = 0; j < session.Cart.length; j++) {
          if (session.Cart[j].kodeproduk == data[i]['kodeproduk'] &&
              int.parse(session.Cart[j].username) == session.userlogin) {
            ClassProduk databaru = ClassProduk(
                data[i]['kodeproduk'].toString(),
                data[i]['nama'].toString(),
                data[i]['namaproduk'].toString(),
                data[i]['kodekategori'].toString(),
                data[i]['kemasan'].toString(),
                data[i]['harga'].toString(),
                data[i]['foto'].toString(),
                data[i]['deskripsi'].toString(),
                data[i]['status'].toString(),
                data[i]['varian'].toString(),
                data[i]['fotokonsultan'].toString(),
                data[i]['konsultan'].toString());
            session.Cart[j].produkini = databaru;
            tempProduk.add(databaru);
          }
        }
      }
      // setState(() => this.arrProduk = tempProduk);
      hitungTotal();
      return tempProduk;
    }).catchError((err) {
      print(err);
    });
  }

  Future<List<ClassProduk>> checkOut() async {
    String data = jsonEncode(session.Cart);
    Map paramData = {'data': data, 'alamat': 1, 'total': total};
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/checkout",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      print(res.body);
    }).catchError((err) {
      print(err);
    });
  }

  void hitungTotal() {
    total = 0;
    jumlah = 0;
    if (session.Cart.length > 0) {
      for (int i = 0; i < session.Cart.length; i++) {
        if (int.parse(session.Cart[i].username) == session.userlogin) {
          setState(() {
            jumlah++;
            total = total +
                int.parse(session.Cart[i].jumlah) *
                    int.parse(session.Cart[i].produkini.harga);
          });
        }
      }
    } else {
      setState(() {
        total = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Column(
              children: [
                Text(
                  "Your Cart",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  jumlah.toString() + " items",
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(height: 15),
            SizedBox(
              height: 100,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text("Alamat Pengiriman"),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 325,
              child: new ListView.builder(
                  itemCount: cartshop.length == 0 ? 0 : cartshop.length,
                  itemBuilder: (context, index) {
                    if (cartshop.length == 0) {
                      return Card(
                        child: Text("Data empty"),
                      );
                    } else {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProdukDetail(
                                        id: session.Cart[index].kodeproduk)));
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: SizedBox(
                                    width: (88 / 375) * size.width,
                                    child: AspectRatio(
                                      aspectRatio: 0.88,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF5F6F9),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Image(
                                          image: NetworkImage(session.ipnumber +
                                              "/gambar/produk/" +
                                              session
                                                  .Cart[index].produkini.foto),
                                        ),
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        session.Cart[index].produkini.varian ==
                                                "-"
                                            ? Text(
                                                session.Cart[index].produkini
                                                    .namaproduk,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                                maxLines: 2,
                                              )
                                            : Text(
                                                session.Cart[index].produkini
                                                        .namaproduk +
                                                    " " +
                                                    session.Cart[index]
                                                        .produkini.varian,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                                maxLines: 2,
                                              ),
                                        SizedBox(height: 10),
                                        int.parse(session.Cart[index].produkini
                                                    .harga) >
                                                1000
                                            ? Text.rich(TextSpan(
                                                text: "Rp " +
                                                    frmt.format(int.parse(
                                                        session.Cart[index]
                                                            .produkini.harga)),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.orange),
                                              ))
                                            : Text.rich(TextSpan(
                                                text: "Rp " +
                                                    session.Cart[index]
                                                        .produkini.harga,
                                                style: TextStyle(
                                                    // fontWeight: FontWeight.w600,
                                                    color: Colors.orange),
                                              ))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      child: Row(
                                        children: [
                                          RawMaterialButton(
                                            constraints:
                                                BoxConstraints(minWidth: 0),
                                            onPressed: () {
                                              setState(() {
                                                if (int.parse(cartshop[index]
                                                        .jumlah) <=
                                                    1) {
                                                  // cartshop[index].jumlah = "0";
                                                  showAlert(index);
                                                } else {
                                                  cartshop[index].jumlah =
                                                      (int.parse(cartshop[index]
                                                                  .jumlah) -
                                                              1)
                                                          .toString();
                                                }
                                                hitungTotal();
                                              });
                                            },
                                            elevation: 0,
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                            fillColor: Colors.grey[200],
                                            padding: EdgeInsets.all(5.0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            cartshop[index].jumlah.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          RawMaterialButton(
                                            constraints:
                                                BoxConstraints(minWidth: 0),
                                            elevation: 0,
                                            onPressed: () {
                                              setState(() {
                                                cartshop[index].jumlah =
                                                    (int.parse(cartshop[index]
                                                                .jumlah) +
                                                            1)
                                                        .toString();
                                                hitungTotal();
                                              });
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                            fillColor: Colors.grey[200],
                                            padding: EdgeInsets.all(5.0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ));
                    }
                  }),
            ),
            SizedBox(height: 25),
            // Row(
            //   children: [Expanded(child: Text("Jasa Pengiriman"))],
            // ),
            Row(
              children: [
                SizedBox(width: 25),
                Expanded(
                    flex: 2,
                    child: total > 0
                        ? Text(
                            "Rp. " + frmt.format(total) + " ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "Rp. 0",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: session.kBlue),
                        child: FlatButton(
                          onPressed: () {
                            checkOut();
                          },
                          child: Text(
                            'Checkout',
                            style: session.kBodyText
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )),
                SizedBox(width: 5)
              ],
            )
          ],
        ));
  }
}
