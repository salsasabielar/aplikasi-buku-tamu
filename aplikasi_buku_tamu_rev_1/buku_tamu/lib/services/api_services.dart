import 'dart:convert';
import 'package:buku_tamu/model/daftarTamu.dart';
import 'package:http/http.dart';

class ApiService {
  final String apiUrl =
      "http://114.4.37.148/bukutamu/index.php/daftartamu/simpan";
  final String apiUrl2 =
      "http://114.4.37.148/bukutamu/index.php/daftartamu/getlist";

  // Future<List> getPopularMovies() async {
  //   final String uri = apiUrl2;

  //    var http;
  //   var res = await http.post(apiUrl2);
  //   if (res.statusCode == HttpStatus.ok) {
  //     print("Sukses");
  //     final jsonResponse = json.decode(res.body);
  //     final moviesMap = jsonResponse['results'];
  //     List movies = moviesMap.map((i) => daftarTamu.fromJson(i)).toList();
  //     return movies;
  //   } else {
  //     print("Fail");
  //     return null;
  //   }
  // }
  Future<List<DaftarTamu>> getDaftarTamu() async {
    var http;
    var res = await http.post(apiUrl);
    print(res.body);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<DaftarTamu> daftarTamu =
          body.map((dynamic item) => DaftarTamu.fromJson(item)).toList();
      return daftarTamu;
    } else {
      throw "Failed to load daftar tamu list";
    }
  }

  Future<List<DaftarTamu>> getDaftarTamuList() async {
    var http;
    var res = await http.post(apiUrl2);
    print(res.body);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<DaftarTamu> daftarTamu =
          body.map((dynamic item) => DaftarTamu.fromJson(item)).toList();
      return daftarTamu;
    } else {
      throw "Failed to load daftar tamu list";
    }
  }

  Future<DaftarTamu> getCaseById(String id) async {
    final response = await get('$apiUrl/$id');

    if (response.statusCode == 200) {
      return DaftarTamu.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a daftar tamu');
    }
  }

  Future<DaftarTamu> createCase(DaftarTamu daftarTamu) async {
    Map data = {
      'nama': daftarTamu.nama,
      'alamat': daftarTamu.alamat,
      'instansi': daftarTamu.instansi,
      'email': daftarTamu.email,
      'telp': daftarTamu.telp,
      'tujuan': daftarTamu.tujuan,
      'keterangan': daftarTamu.keterangan
    };

    final Response response = await post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return DaftarTamu.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post daftar tamu');
    }
  }

  // Future<DaftarTamu> updateDaftarTamu(String id, DaftarTamu daftarTamu) async {
  //   Map data = {
  //     'nama': daftarTamu.nama,
  //     'alamat': daftarTamu.alamat,
  //     'instansi': daftarTamu.instansi,
  //     'email': daftarTamu.email,
  //     'telp': daftarTamu.telp,
  //     'tujuan': daftarTamu.tujuan,
  //     'keterangan': daftarTamu.keterangan
  //   };

  //   final Response response = await put(
  //     '$apiUrl/$id',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(data),
  //   );
  //   if (response.statusCode == 200) {
  //     return DaftarTamu.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to update a case');
  //   }
  // }

  Future<void> deleteCase(String id) async {
    Response res = await delete('$apiUrl/$id');

    if (res.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }
}
