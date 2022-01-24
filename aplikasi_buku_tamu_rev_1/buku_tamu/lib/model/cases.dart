class Cases {
  final String id;
  final String nama;
  final String alamat;
  final String instansi;
  final String email;
  final String telp;
  final String tujuan;
  final String keterangan;

  Cases({ this.id, this.nama, this.alamat, this.instansi, this.email, this.telp, this.tujuan, this.keterangan });

  factory Cases.fromJson(Map<String, dynamic> json) {
    return Cases(
      id: json['_id'] as String,
      nama: json['nama'] as String,
      alamat: json['alamat'] as String,
      instansi: json['instansi'] as String,
      email: json['email'] as String,
      telp: json['telp'] as String,
      tujuan: json['tujuan'] as String,
      keterangan: json['keterangan'] as String,
      
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $nama}';
  }
}