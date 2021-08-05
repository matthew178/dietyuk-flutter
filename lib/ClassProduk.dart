// import 'package:intl/intl.dart';

class ClassProduk {
//   int id, estimasi, harga, durasi, status, rating, konsultan;
  String kodeproduk,
      konsultan,
      namaproduk,
      kodekategori,
      kemasan,
      harga,
      foto,
      deskripsi,
      status,
      varian,
      fotokonsultan,
      idkonsultan;

  ClassProduk(
      this.kodeproduk,
      this.konsultan,
      this.namaproduk,
      this.kodekategori,
      this.kemasan,
      this.harga,
      this.foto,
      this.deskripsi,
      this.status,
      this.varian,
      this.fotokonsultan,
      this.idkonsultan);

  Map toJson() => {
        'kodeproduk': kodeproduk,
        'namaproduk': namaproduk,
        'kodekategori': kodekategori,
        'kemasan': kemasan,
        'harga': harga,
        'foto': foto,
        'deskripsi': deskripsi,
        'status': status,
        'varian': varian,
        'fotokonsultan': fotokonsultan,
        'idkonsultan': idkonsultan
      };
}
