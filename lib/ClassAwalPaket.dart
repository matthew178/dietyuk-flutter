class ClassAwalPaket {
  String id,
      hari,
      tanggal,
      week,
      idperkembangan,
      idbeli,
      username,
      berat,
      status,
      tipe;

  ClassAwalPaket(this.id, this.hari, this.tanggal, this.week, this.tipe);

  void setidperkembangan(String id) {
    this.idperkembangan = id;
  }

  void setidbeli(String id) {
    this.idbeli = id;
  }

  void setusername(String uname) {
    this.username = uname;
  }

  void setberat(String berat) {
    this.berat = berat;
  }

  void setstatus(String status) {
    this.status = status;
  }

  void settipe(String tipe) {
    this.tipe = tipe;
  }
}
