import 'session.dart' as session;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'ClassUser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'Provinsi.dart';

class Editprofile extends StatefulWidget {
  @override
  EditprofileState createState() => EditprofileState();
}

class EditprofileState extends State<Editprofile> {
  String foto = "assets/images/pria.jpg";
  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController nomorhp = new TextEditingController();
  TextEditingController berat = new TextEditingController();
  TextEditingController tinggi = new TextEditingController();
  List<Provinsi> arrProvinsi = new List();

  File _image;

  ClassUser userprofile = new ClassUser(
      "", "", "", "", "", "", "", "", "", "", "", "", "0", "", "");

  void initState() {
    super.initState();
    getProfile();
    getProvinsi();
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
    // Map paramData = {'province': provinsi};
    // var parameter = json.encode(paramData);
    // if (myPassword.text == confirmPassword.text) {
    //   http
    //       .post(session.ipnumber + "/register",
    //           headers: {"Content-Type": "application/json"}, body: parameter)
    //       .then((res) {
    //     print(res.body);
    //   }).catchError((err) {
    //     print(err);
    //   });
    // }
    // return "";
  }

  Future<String> editProfile() async {
    String base64Image = "";
    String namaFile = "";

    if (_image != null) {
      base64Image = base64Encode(_image.readAsBytesSync()); //mimage
      namaFile = _image.path.split("/").last + ".png"; //mfile
      print("not null");
    } else {
      print("image is null");
    }
    Map paramData = {
      'nama': nama.text,
      'username': username.text,
      'email': email.text,
      'nomorhp': nomorhp.text,
      'berat': berat.text,
      'tinggi': tinggi.text,
      'id': session.userlogin,
      'm_filename': namaFile,
      'm_image': base64Image
    };
    var parameter = json.encode(paramData);
    http
        .post(session.ipnumber + "/editprofile",
            headers: {"Content-Type": "application/json"}, body: parameter)
        .then((res) {
      print(res.body);
      if (session.role == "member")
        Navigator.pushNamed(this.context, "/member");
      else
        Navigator.pushNamed(this.context, "/konsultan");
    }).catchError((err) {
      print(err);
    });

    return "";
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });

    String namaFile = image.path;
    String basenamegallery = basename(namaFile);
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
      username.text = userprofile.username;
      email.text = userprofile.email;
      nama.text = userprofile.nama;
      nomorhp.text = userprofile.nomorhp;
      berat.text = userprofile.berat;
      tinggi.text = userprofile.tinggi;
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
    String img = "";
    if (userprofile.jeniskelamin == "pria" && userprofile.foto == "pria.png")
      img = "assets/images/pria.jpg";
    else if (userprofile.jeniskelamin == "wanita" &&
        userprofile.foto == "wanita.png")
      img = "assets/images/wanita.png";
    else
      img = session.ipnumber + "/gambar/" + userprofile.foto;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: session.warna,
      ),
      body: Center(
        child: ListView(children: <Widget>[
          SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.network(
              this.foto,
              width: 150,
              height: 150,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Center(
              child: TextFormField(
                controller: username,
                keyboardType: TextInputType.text,
                autofocus: true,
                decoration:
                    InputDecoration(labelText: "Username", hintText: ""),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Center(
              child: TextFormField(
                controller: email,
                keyboardType: TextInputType.text,
                autofocus: true,
                decoration: InputDecoration(labelText: "Email", hintText: ""),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Center(
              child: TextFormField(
                controller: nama,
                keyboardType: TextInputType.text,
                autofocus: true,
                decoration: InputDecoration(labelText: "Nama", hintText: ""),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Center(
              child: TextFormField(
                controller: nomorhp,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration:
                    InputDecoration(labelText: "Nomor HP", hintText: ""),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Center(
              child: TextFormField(
                controller: berat,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration:
                    InputDecoration(labelText: "Berat(kg)", hintText: ""),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Center(
              child: TextFormField(
                controller: tinggi,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration:
                    InputDecoration(labelText: "Tinggi(cm)", hintText: ""),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: Center(
              child: _image == null
                  ? Text('No Image Selected.')
                  : Image.file(_image),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 10, 0),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                onPressed: () {
                  getImageFromGallery();
                },
                color: Colors.lightBlueAccent,
                child: Text(
                  'Ganti Foto Profil',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 10, 0),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                onPressed: () {
                  editProfile();
                },
                color: Colors.lightBlueAccent,
                child: Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
