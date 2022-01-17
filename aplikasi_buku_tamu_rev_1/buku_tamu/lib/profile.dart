import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'login.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Positioned(
              child: Container(
                child: Align(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/l tt.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 200,
                    height: 200,
                  ),
                ),
                height: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20.0,
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        color: Colors.blue[50],
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Profile",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    fontSize: 30.0),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                'Tipe User : ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w100),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                'Nama : ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w100),
                              ),
                            ],
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // tombol
            Expanded(
              child: Card(
                color: Colors.blue[50],
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Klik tombol logout ' +
                                '\n' +
                                'untuk keluar dari aplikasi  buku tamu ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w100),
                          ),

                          Expanded(
                              child: SizedBox(
                             width: 50,
                          )),
                          Expanded(
                              child: SizedBox(
                            width: 30,
                          )),
                          // tombol kembali
                          RaisedButton(
                            color: Colors.blue[100],
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  CupertinoPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              'Logout',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          decoration: BoxDecoration(color: Colors.blue[200]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: Icon(Icons.home), iconSize: 30, onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.person), iconSize: 30, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
