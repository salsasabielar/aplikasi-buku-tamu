import 'dart:io';
import 'package:buku_tamu/model/tamu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'login.dart';

class Report extends StatefulWidget {
  @override
  ReportState createState() => ReportState();
}

class ReportState extends State<Report> {
  List<Tamu> tamuList = [];

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
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: <DataColumn>[
                              DataColumn(label: Text("Nama")),
                              DataColumn(label: Text("Instansi / Alamat")),
                              DataColumn(label: Text("Menemui")),
                              DataColumn(label: Text("Keperluan")),
                              // DataColumn(label: Text("Tanggal / Waktu")),
                              // DataColumn(label: Text("Tanda Tangan")),
                              // DataColumn(label: Text("Foto")),
                            ],
                            rows:
                                tamuList // Loops through dataColumnText, each iteration assigning the value to element
                                    .map(
                                      ((element) => DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text(element.nama)),
                                              DataCell(Text(element.instansi)),
                                              DataCell(Text(element.menemui)),
                                              DataCell(Text(element.keperluan)),
                                            ],
                                          )),
                                    )
                                    .toList(),
                            // rows: <DataRow>[
                            //   DataRow(
                            //     cells: <DataCell>[
                            //       DataCell(Text("Ice Cream Sandwich")),
                            //       DataCell(Text("237")),
                            //       DataCell(Text("9.0")),
                            //       DataCell(Text("4.3")),
                                // ],
                              ),
                            //   DataRow(
                            //     cells: <DataCell>[
                            //       DataCell(Text("Eclair")),
                            //       DataCell(Text("262")),
                            //       DataCell(Text("16.0")),
                            //       DataCell(Text("6.0")),
                            //     ],
                            //   ),
                            // ],
                          ),
                        ),
                      ),
                    // ),
                    //Expanded(
                        // child: SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: DataTable(
                        //     columns: <DataColumn>[
                        //       DataColumn(label: Text("Nama")),
                        //       DataColumn(label: Text("Instansi / Alamat")),
                        //       DataColumn(label: Text("Menemui")),
                        //       DataColumn(label: Text("Keperluan")),
                        //       // DataColumn(label: Text("Tanggal / Waktu")),
                        //       // DataColumn(label: Text("Tanda Tangan")),
                        //       // DataColumn(label: Text("Foto")),
                        //     ],
                        //     rows:
                        //         tamuList // Loops through dataColumnText, each iteration assigning the value to element
                        //             .map(
                        //               ((element) => DataRow(
                        //                     cells: <DataCell>[
                        //                       DataCell(Text(element.nama)),
                        //                       DataCell(Text(element.instansi)),
                        //                       DataCell(Text(element.menemui)),
                        //                       DataCell(Text(element.keperluan)),
                        //                     ],
                        //                   )),
                        //             )
                        //             .toList(),
                            // rows: <DataRow>[
                            //   DataRow(
                            //     cells: <DataCell>[
                            //       DataCell(Text("Ice Cream Sandwich")),
                            //       DataCell(Text("237")),
                            //       DataCell(Text("9.0")),
                            //       DataCell(Text("4.3")),
                            //     ],
                            //   ),
                            //   DataRow(
                            //     cells: <DataCell>[
                            //       DataCell(Text("Eclair")),
                            //       DataCell(Text("262")),
                            //       DataCell(Text("16.0")),
                            //       DataCell(Text("6.0")),
                            //     ],
                            //   ),
                            // ],
                        //   ),
                        // ),
                       // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
