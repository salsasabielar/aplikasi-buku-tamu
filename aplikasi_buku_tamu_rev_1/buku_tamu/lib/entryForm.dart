//ENTRY FORM DENGAN SQLITE

import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:buku_tamu/dbhelper.dart';
import 'package:buku_tamu/model/cases.dart';
import 'package:buku_tamu/model/daftarTamu.dart';
import 'package:buku_tamu/model/tamu.dart';
import 'package:buku_tamu/services/api_services.dart';
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
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

  var dbHelper;
  bool _validate = false;
  var isUserNameValidate;
  EntryFormState(this.tamu);
  final ApiService api = ApiService();
  // final _addFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = new GlobalKey();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController instansiController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController tujuanController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
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

  File tmpFile;

  var now = DateTime.now();
  Future addRecord() async {
    var db = DbHelper();
    String dateNow =
        "${now.day}-${now.month}-${now.year} / ${now.hour}:${now.minute}";

    var tamu = Tamu(
        namaController.text,
        alamatController.text,
        instansiController.text,
        emailController.text,
        telpController.text,
        tujuanController.text,
        keteranganController.text,
        dateNow,
        cameraFile.path.toString(),
        _imgTtd);
    await db.insert(tamu);
  }

  // var Share;
  void clearInputText() {
    namaController.text = "";
    alamatController.text = "";
    instansiController.text = "";
    emailController.text = "";
    telpController.text = "";
    tujuanController.text = "";
    keteranganController.text = "";
  }

  File uploadimage;
  @override
  Widget build(BuildContext context) {
    selectFromCamera() async {
      cameraFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );
      setState(() {
        uploadimage = cameraFile;
      });
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
      final result =
          await ImageGallerySaver.saveImage(bytes, name: name, quality: 10);
      var path = await FlutterAbsolutePath.getAbsolutePath(result['filePath']);
      print(path);
      //tmpFile = cameraFile;
      setState(
        () {
          _imgTtd = path.toString();
        },
      );
      return result['filePath'];
    }

    final imageEncoded = base64.encode(imageData);
    // final String uploadEndPoint =
    //     "http://114.4.37.148/bukutamu/index.php/daftartamu/uploadfoto";
    // Future<File> file;
    // String status = '';
    // String base64Image;
    // String errMessage = 'Error Uploading Image';

    // setStatus(String message) {
    //   setState(() {
    //     status = message;
    //   });
    // }

    // upload(String fileName) {
    //   print("upload suksessssss3333");
    //   http.post(uploadEndPoint, body: {
    //     "image": base64Image,
    //     "name": fileName,
    //   }).then((result) {
    //     setStatus(result.statusCode == 200 ? result.body : errMessage);
    //   }).catchError((error) {
    //     setStatus(error);
    //   });

    //   print("upload suksessssss44444");
    // }

    // startUpload() {
    //   print("upload suksessssss");
    //   setStatus("Uploading Image...");
    //   if (null == tmpFile) {
    //     setStatus(errMessage);
    //     print("upload suksessssss return");
    //     return;
    //   }

    //   String fileName = tmpFile.path.split('/').last;
    //   print("upload suksessssss111");
    //   upload(fileName);
    //   print("upload suksessssss2222");
    // }

    // void _saveForm() {
    //   final isValid = _formKey.currentState.validate();
    //   if (!isValid) {
    //     return;
    //   }
    // }

    // uploadFile() async {
    //   var postUri = Uri.parse(
    //       "<http://114.4.37.148/bukutamu/index.php/daftartamu/uploadfoto>");
    //   var request = new http.MultipartRequest("POST", postUri);
    //   request.files.add(
    //     new http.MultipartFile.fromBytes(
    //       'file',
    //       await File.fromUri(Uri.parse("<path/to/file>")).readAsBytes(),
    //       contentType: new MediaType('image', 'jpeg')));

    //   request.send().then((response) {
    //     if (response.statusCode == 200) print("Uploaded!");
    //   });
    // }

    // uploadFileToServer(File imagePath) async {
    //   var request = new http.MultipartRequest(
    //       "POST",
    //       Uri.parse(
    //           'http://114.4.37.148/bukutamu/index.php/daftartamu/uploadfoto'));

    //   request.files.add(
    //       await http.MultipartFile.fromPath('profile_pic', imagePath.path));
    //   request.send().then((response) {
    //     http.Response.fromStream(response).then((onValue) {
    //       try {
    //         print(onValue.body);

    //         // print("upload suksessssss dongggg");
    //       } catch (e) {
    //         // handle exeption
    //         print("upload gagalllll");
    //       }
    //     });
    //   });
    // }

    // _asyncFileUpload(String text, File file) async {
    //   //create multipart request for POST or PATCH method
    //   var request = http.MultipartRequest(
    //       "POST",
    //       Uri.parse(
    //           "http://114.4.37.148/bukutamu/index.php/daftartamu/uploadfoto"));
    //   //add text fields
    //   request.fields["text_field"] = text;
    //   //create multipart using filepath, string or bytes
    //   var pic = await http.MultipartFile.fromPath("file_field", file.path);
    //   //add multipart to request
    //   request.files.add(pic);
    //   var response = await request.send();

    //   //Get the response from the server
    //   var responseData = await response.stream.toBytes();
    //   var responseString = String.fromCharCodes(responseData);
    //   print(responseString);
    // }

    //   Future<void> chooseImage() async {
    //       var choosedimage;
    //       //set source: ImageSource.camera to get image from camera
    //       setState(() {
    //           cameraFile = choosedimage;
    //       });
    // }

    Future<void> uploadImage() async {
      //show your own loading or progressing code here

      String uploadurl =
          "http://114.4.37.148/bukutamu/index.php/daftartamu/uploadfoto";
      //dont use http://localhost , because emulator don't get that address
      //insted use your local IP address or use live URL
      //hit "ipconfig" in windows or "ip a" in linux to get you local IP

      List<int> imageBytes = uploadimage.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      print(baseimage);
      //convert file image to Base64 encoding
      var fileName;
      var response = await http.post(uploadurl, body: {
        "image": baseimage,
        "name": fileName,
      });
      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        print(response.body); //decode json data
        if (jsondata["error"]) {
          //check error sent from server
          print(jsondata["msg"]);
          //if error return from server, show message from server
        } else {
          print("Upload successful");
        }
      } else {
        print("Error during connection to server");
        //there is error during connecting to server,
        //status code might be 404 = url not found
      }
      // } catch (e) {
      //   print("Error during converting to Base64");
      //   //there is error during converting file image to base64 encoding.
      // }
    }

    //rubah
    return Scaffold(
      // appBar: AppBar(
      backgroundColor: Colors.blue[50],
      // leading: Icon(Icons.keyboard_arrow_left),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: Form(
            key: _formKey,
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

                //Nama
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
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
                    // onChanged: (value) {
                    //   //
                    // },
                    validator: (text) {
                      if (!(text.length > 5) && text.isNotEmpty) {
                        return "Enter valid name of more then 5 characters!";
                      }
                      return null;
                    },
                  ),
                ),

                //alamat
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: alamatController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Alamat',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // onChanged: (value) {
                    //   //
                    // },
                  ),
                ),

                //instansi
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: instansiController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Instansi',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // onChanged: (value) {
                    //   //
                    // },
                  ),
                ),

                // email
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // onChanged: (value) {
                    //   //
                    // },
                  ),
                ),

                //telp
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: telpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Telepon',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // onChanged: (value) {
                    //   //
                    // },
                  ),
                ),

                //tujuan
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: tujuanController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Tujuan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // onChanged: (value) {
                    //   //
                    // },
                  ),
                ),

                //Keterangan
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: keteranganController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Keterangan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // onChanged: (value) {
                    //   //
                    // },
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
                    SizedBox(
                      height: 30,
                    ),
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
                          child:
                              Text('Simpan', style: TextStyle(fontSize: 20.0)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () async {
                            // _saveForm();
                            final image = await screenshotController.capture();
                            if (image == null) return;
                            await saveImage(image);
                            if (tamu == null) {
                              // tambah data
                              tamu = Tamu(
                                  namaController.text,
                                  alamatController.text,
                                  instansiController.text,
                                  emailController.text,
                                  telpController.text,
                                  tujuanController.text,
                                  keteranganController.text,
                                  createDateController.text,
                                  cameraFile.path.toString(),
                                  _imgTtd);

                              //menambahkan waktu sekarang

                              addRecord(); //menyimpan data
                              // print("sebelum upload gambar");
                              // startUpload();

                              // print("setelah upload gambar");
                              api.createCase(Cases(
                                  nama: namaController.text,
                                  alamat: alamatController.text,
                                  instansi: instansiController.text,
                                  email: emailController.text,
                                  telp: telpController.text,
                                  tujuan: tujuanController.text,
                                  keterangan: keteranganController.text));

                              // // kembali ke layar sebelumnya dengan membawa objek tamu
                              //uploadFileToServer(cameraFile);
                              //_asyncFileUpload("", cameraFile);
                              //uploadFile();
                              uploadImage();

                              Navigator.pop(context, tamu);
                            }
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
      ),
    );
  }
}
