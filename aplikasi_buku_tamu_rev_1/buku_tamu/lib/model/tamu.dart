class Tamu {
  int _id;
  String _nama;
  String _instansi;
  String _menemui;
  String _keperluan;
  String _createDate;
  String _imgPhoto;
  String _imgTtd;
  //String _ttd;

  int get id => _id;

  String get nama => this._nama;
  set nama(String value) => this._nama = value;

  String get instansi => this._instansi;
  set instansi(String value) => this._instansi = value;

  String get menemui => this._menemui;
  set menemui(String value) => this._menemui = value;

  String get keperluan => this._keperluan;
  set keperluan(String value) => this._keperluan = value;

  String get createDate => this._createDate;
  set createDate(String value) => this._createDate = value;

  String get imgPhoto => this._imgPhoto;
  set imgPhoto(String value) => this._imgPhoto = value;

  String get imgTtd => this._imgTtd;
  set imgTtd(String value) => this._imgTtd = value;

  // String get ttd => this._ttd;
  // set ttd(String value) => this._ttd = value;

// konstruktor versi 1
  Tamu(this._nama, this._instansi, this._menemui, this._keperluan,
      this._createDate, this._imgPhoto, this._imgTtd);

// konstruktor versi 2: konversi dari Map ke Tamu
  Tamu.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nama = map['nama'];
    this._instansi = map['instansi'];
    this._menemui = map['menemui'];
    this._keperluan = map['keperluan'];
    this._createDate = map['createDate'];
    this._imgPhoto = map['photo'];
    this._imgTtd = map['ttd'];
    // this._ttd = map['ttd'];
  }

  // konversi dari Tamu ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['nama'] = nama;
    map['instansi'] = instansi;
    map['menemui'] = menemui;
    map['keperluan'] = keperluan;
    map['createDate'] = createDate;
    map['photo'] = imgPhoto;
    map['ttd'] = imgTtd;
    // map['ttd'] = ttd;
    return map;
  }
}
