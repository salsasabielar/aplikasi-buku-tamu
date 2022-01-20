//ENTRI FORM UNTUK API

import 'package:buku_tamu/model/daftarTamu.dart';
import 'package:buku_tamu/services/api_services.dart';
import 'package:flutter/material.dart';

class EntryForm extends StatefulWidget {
  EntryForm();

  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  _EntryFormState();

  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _instansiController = TextEditingController();
  final _emailController = TextEditingController();
  final _telpController = TextEditingController();
  final _tujuanController = TextEditingController();
  final _keteranganController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Cases'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextField(
                            controller: _namaController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Nama',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (value) {
                              //
                            },
                          ),
                        ),
                        //alamat
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextField(
                            controller: _alamatController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Alamat',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (value) {
                              //
                            },
                          ),
                        ),
                        //instansi
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextField(
                            controller: _instansiController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Instansi',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (value) {
                              //
                            },
                          ),
                        ),
                        // email
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (value) {
                              //
                            },
                          ),
                        ),

                        //telp
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextField(
                            controller: _telpController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'No Telepon',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (value) {
                              //
                            },
                          ),
                        ),

                        //tujuan
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextField(
                            controller: _tujuanController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Tujuan',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (value) {
                              //
                            },
                          ),
                        ),
                        //Keterangan
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextField(
                            controller: _keteranganController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Keterangan',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (value) {
                              //
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                splashColor: Colors.red,
                                onPressed: () {
                                  if (_addFormKey.currentState.validate()) {
                                    _addFormKey.currentState.save();
                                    api.createCase(DaftarTamu(
                                        nama: _namaController.text,
                                        alamat: _alamatController.text,
                                        instansi: _instansiController.text,
                                        email: _emailController.text,
                                        telp: _telpController.text,
                                        tujuan: _tujuanController.text,
                                        keterangan:
                                            _keteranganController.text));

                                    Navigator.pop(context);
                                  }
                                },
                                child: Text('Save',
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
