// import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:buku_tamu/dbhelper.dart';
import 'package:buku_tamu/model/tamu.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:signature/signature.dart';
import 'dart:core';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class EntryForm extends StatefulWidget {
  String imagePath;
  CameraController controller;
  List cameras;
  int selectedCameraIdx;
  final Tamu tamu;
  EntryForm(this.tamu);

  @override
  EntryFormState createState() => EntryFormState(this.tamu);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Tamu tamu;
  EntryFormState(this.tamu);
  final TextEditingController namaController = TextEditingController();
  final TextEditingController instansiController = TextEditingController();
  final TextEditingController menemuiController = TextEditingController();
  final TextEditingController keperluanController = TextEditingController();
  TextEditingController createDateController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  double textSize = 20;
  File cameraFile;
  String _imgTtd;
  final SignatureController ttdController = SignatureController(
    penStrokeWidth: 2,
    exportBackgroundColor: Colors.white,
    penColor: Colors.black,
  );

  var now = DateTime.now();
  Future addRecord() async {
    var db = DbHelper();
    String dateNow =
        "${now.day}-${now.month}-${now.year} / ${now.hour}:${now.minute}";

    var tamu = Tamu(
        namaController.text,
        instansiController.text,
        menemuiController.text,
        keperluanController.text,
        dateNow,
        cameraFile.path.toString(),
        _imgTtd);
    await db.insert(tamu);
  }

  // var Share;
  void clearInputText() {
    namaController.text = "";
    instansiController.text = "";
    menemuiController.text = "";
    keperluanController.text = "";
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(widget.imagePath).readAsBytesSync() as Uint8List;
    return ByteData.view(bytes.buffer);
  }

  @override
  Widget build(BuildContext context) {
    selectFromCamera() async {
      cameraFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );
      GallerySaver.saveImage(cameraFile.path);
      print(cameraFile.path);

      setState(() {});
    }

    Future<String> saveImage(Uint8List bytes) async {
      await [Permission.storage].request();
      final time = DateTime.now()
          .toIso8601String()
          .replaceAll(".", "-")
          .replaceAll(":", "-");
      final name = "ttd-$time";
      final result = await ImageGallerySaver.saveImage(bytes, name: name);
      var path = await FlutterAbsolutePath.getAbsolutePath(result['filePath']);
      print(path);
      setState(() {
        _imgTtd = path.toString();
      });
      return result['filePath'];
    }

    //rubah
    return Scaffold(
      // appBar: AppBar(
      backgroundColor: Colors.blue[50],
      // leading: Icon(Icons.keyboard_arrow_left),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: Positioned(
                  child: Container(
                    child: Align(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/l tt.png'),
                            //fit: BoxFit.cover,
                          ),
                        ),
                        width: 200,
                        height: 300,
                      ),
                    ),
                    height: 150,
                  ),
                ),
              ),
              //jam
              // Container(

              //   child: Text(tgl.toString()),
              // ),
              // nama
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextField(
                  controller: namaController,
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

              //instansi
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextField(
                  controller: instansiController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Instansi / Alamat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // menemui
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextField(
                  controller: menemuiController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Menemui',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // Keperluan
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextField(
                  controller: keperluanController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Keperluan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // Tanda Tangan
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: 470.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.refresh,
                              size: 28,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  ttdController.clear();
                                },
                              );
                            },
                          ),
                        ),
                        Text(
                          'Ulangi',
                          style: TextStyle(color: Colors.blue, fontSize: 18.0
                              //fontWeight: FontWeight.bold
                              ),
                        ),
                      ],
                    ),
                  ),
                  Screenshot(
                    controller: screenshotController,
                    child: Signature(
                      height: 300,
                      width: 475,
                      backgroundColor: Colors.white,
                      controller: ttdController,
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  SizedBox(height: 30,),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 470.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              icon: Icon(Icons.camera_alt_rounded,
                                  size: 28, color: Colors.blueGrey),
                              onPressed: selectFromCamera),
                        ),
                        Text(
                          'Kamera',
                          style: TextStyle(color: Colors.blue, fontSize: 18.0
                              //fontWeight: FontWeight.bold
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //kamera
              Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                    ),
                    SizedBox(
                      height: 350.0,
                      width: 500.0,
                      child: cameraFile == null
                          ? Center(
                              child: new Text('Ambil Foto Terlebih Dahulu!'))
                          : Center(child: new Image.file(cameraFile)),
                    )
                  ],
                ),
              ),

              // tombol
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // tombol simpan
                    Container(
                      width: 150,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorLight,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text('Simpan', style: TextStyle(fontSize: 20.0)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () async {
                          final image = await screenshotController.capture();
                          if (image == null) return;
                          await saveImage(image);
                          if (tamu == null) {
                            // tambah data
                            tamu = Tamu(
                                namaController.text,
                                instansiController.text,
                                menemuiController.text,
                                keperluanController.text,
                                createDateController.text,
                                cameraFile.path.toString(),
                                _imgTtd);
                          } else {
                            // ubah data
                            tamu.nama = namaController.text;
                            tamu.instansi = instansiController.text;
                            tamu.menemui = menemuiController.text;
                            tamu.keperluan = keperluanController.text;
                            tamu.createDate = createDateController.text;
                          }
                          //menambahkan waktu sekarang
                          addRecord();
                          // kembali ke layar sebelumnya dengan membawa objek tamu

                          Navigator.pop(context, tamu);
                        },
                      ),
                    ),
                    Container(
                      width: 25.0,
                    ),
                    // tombol batal
                    Container(
                      width: 150,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorLight,
                        textColor: Theme.of(context).primaryColorDark,
                        child:
                            Text('Kembali', style: TextStyle(fontSize: 20.0)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
