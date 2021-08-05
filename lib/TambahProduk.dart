import 'package:image_picker/image_picker.dart';
import 'package:dietyuk/ClassKategoriProduk.dart';
import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

class TambahProduk extends StatefulWidget {
  @override
  TambahProdukState createState() => TambahProdukState();
}

class TambahProdukState extends State<TambahProduk> {
  TextEditingController namaProduk = new TextEditingController();
  TextEditingController hargaProduk = new TextEditingController();
  TextEditingController kemasanProduk = new TextEditingController();
  TextEditingController deskripsiProduk = new TextEditingController();
  TextEditingController varianProduk = new TextEditingController();

  ClassKategoriProduk kategori = null;
  List<ClassKategoriProduk> arrKategori = new List();

  File _image;

  void initState() {
    super.initState();
    getKategori();
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });

    String namaFile = image.path;
    String basenamegallery = basename(namaFile);
  }

  Future<List<ClassKategoriProduk>> getKategori() async {
    List<ClassKategoriProduk> tempKategori = new List();
    Map paramData = {};
    var parameter = json.encode(paramData);
    ClassKategoriProduk databaru =
        new ClassKategoriProduk("id", "id_paket", "gambar", "icon");
    http
        .post(session.ipnumber + "/getkategori",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      var data = json.decode(res.body);
      data = data[0]['kategori'];
      for (int i = 0; i < data.length; i++) {
        databaru = ClassKategoriProduk(
            data[i]['kodekategori'].toString(),
            data[i]['namakategori'].toString(),
            data[i]['gambar'].toString(),
            data[i]['icon'].toString());
        tempKategori.add(databaru);
      }
      setState(() => this.arrKategori = tempKategori);
      return tempKategori;
    }).catchError((err) {
      print(err);
    });
  }

  void addProduk() async {
    Map paramData = {
      'konsultan': session.userlogin,
      'nama': namaProduk.text,
      'kategori': kategori.kodekategori,
      'kemasan': kemasanProduk.text,
      'harga': hargaProduk.text,
      'deskripsi': deskripsiProduk.text,
      'varian': varianProduk.text
    };
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/getkategori",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {})
        .catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Produk Page"),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                controller: namaProduk,
                keyboardType: TextInputType.text,
                autofocus: true,
                decoration: InputDecoration(labelText: "Nama Produk"),
                validator: (value) =>
                    value.isEmpty ? "Nama tidak boleh kosong" : null,
              ),
            ),
            DropdownButton<ClassKategoriProduk>(
              style: Theme.of(context).textTheme.title,
              hint: Text("Kategori Produk"),
              value: kategori,
              onChanged: (ClassKategoriProduk value) {
                setState(() => {this.kategori = value});
              },
              items: arrKategori.map((ClassKategoriProduk kategori) {
                return DropdownMenuItem<ClassKategoriProduk>(
                  value: kategori,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        kategori.namakategori,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                controller: kemasanProduk,
                keyboardType: TextInputType.text,
                autofocus: true,
                decoration: InputDecoration(labelText: "Kemasan"),
                validator: (value) =>
                    value.isEmpty ? "Detail Kemasan tidak boleh kosong" : null,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                controller: hargaProduk,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: InputDecoration(labelText: "Harga"),
                validator: (value) =>
                    value.isEmpty ? "Detail Kemasan tidak boleh kosong" : null,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                controller: deskripsiProduk,
                keyboardType: TextInputType.text,
                autofocus: true,
                decoration: InputDecoration(labelText: "Deskripsi Produk"),
                validator: (value) => value.isEmpty
                    ? "Deskripsi Produk tidak boleh kosong"
                    : null,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                controller: varianProduk,
                keyboardType: TextInputType.text,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "Varian Produk",
                    hintText: 'Jika tidak ada isi dengan "-"'),
                validator: (value) =>
                    value.isEmpty ? "Varian Produk tidak boleh kosong" : null,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 30, 10, 0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  onPressed: () {
                    getImageFromGallery();
                  },
                  color: Colors.lightBlueAccent,
                  child: Text(
                    'Tambah Gambar Produk',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 10, 25),
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: Center(
                child: _image == null
                    ? Text('No Image Selected.')
                    : Image.file(_image),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 30, 10, 10),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  onPressed: () {
                    addProduk();
                  },
                  color: Colors.lightBlueAccent,
                  child: Text(
                    'Tambah',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
