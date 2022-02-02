import 'dart:convert';
import 'package:buku_tamu/model/cases.dart';
// import 'package:dio/dio.dart';
import 'package:gallery_saver/files.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  final String apiUrl =
      "http://114.4.37.148/bukutamu/index.php/daftartamu/simpan";

  Future<List<Cases>> getCases() async {
    var http;
    var res = await http.post(apiUrl);
    print(res.body);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Cases> cases =
          body.map((dynamic item) => Cases.fromJson(item)).toList();
      return cases;
    } else {
      throw "Failed to load cases list";
    }
  }

  Future<Cases> getCaseById(String id) async {
    final response = await get('$apiUrl/$id');

    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<Cases> createCase(Cases cases) async {
    Map data = {
      'nama': cases.nama,
      'alamat': cases.alamat,
      'instansi': cases.instansi,
      'email': cases.email,
      'telp': cases.telp,
      'tujuan': cases.tujuan,
      'keterangan': cases.keterangan,
      'namafile': cases.namafile
    };

    final Response response = await post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    print(data);

    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post cases');
    }
  }

  // Future<Cases> updateCases(String id, Cases cases) async {
  //   Map data = {
  //     'nama': cases.nama,
  //     'alamat': cases.alamat,
  //     'instansi': cases.instansi,
  //     'email': cases.email,
  //     'telp': cases.telp,
  //     'tujuan': cases.tujuan,
  //     'keterangan': cases.keterangan,
  //     'namafile': cases.namafile
  //   };

  //   final Response response = await put(
  //     '$apiUrl/$id',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(data),
  //   );
  //   if (response.statusCode == 200) {
  //     return Cases.fromJson(json.decode(response.body));
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
