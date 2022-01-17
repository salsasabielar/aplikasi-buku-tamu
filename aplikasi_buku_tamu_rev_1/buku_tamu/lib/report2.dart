// import 'package:flutter/material.dart';
// import 'model/tamu.dart';
// // import 'package:generator_app/service/areaservice.dart';

// class Report extends StatefulWidget {
//   //properti
//   // final Tamu tamu;
//   // //konstruktor
//   // Report({Key key, @required this.tamu}) : super(key: key);

//   @override
//   _ReportState createState() => _ReportState();
// }

// class _ReportState extends State<Report> {
//   List<Tamu> tamuList = [];
//  // bool loading = true;
//   // Future fetchAllArea()async{
//   //   tamuList = await AreaService().fetchAllArea();
//   //   setState(() {
//   //     loading=false;
//   //   });
//   // }
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // fetchAllArea();
//   // }
//   //properti
//   // Tamu tamu;
//   // List<Map<String, dynamic>> tamuList;
//   List<DataCell> ldc = <DataCell>[];
//   // Map<String, dynamic> map = Map<String, dynamic>();

//   //konstruktor
//   // _ReportState({@required this.tamu}) : super();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:  Container(
//         //scrollDirection: Axis.horizontal,
//         // child: DataTable(
//         //   columns: [
//         //     DataColumn(label: Text("No")),
//         //     DataColumn(label: Text("Nama")),
//         //     // DataColumn(label: Text("Instansi / Alamat")),
//         //     // DataColumn(label: Text("Menemui")),
//         //     // DataColumn(label: Text("Keperluan")),
//         //     // DataColumn(label: Text("TTD")),
//         //     // DataColumn(label: Text("Foto")),
//         //   ],
//         //   rows:
//         //     tamuList // Loops through dataColumnText, each iteration assigning the value to element
//         //         .map(
//         //           ((element) => DataRow(
//         //                 cells: <DataCell>[
                          
//         //                   DataCell(Text(element.nama)),
//         //                   DataCell(Text(element.instansi)),
                          
//         //                 ],
//         //               )),
//         //         )
//         //         .toList(),
//         // ),
//       ),
//     );
//   }
// }
// // body: SingleChildScrollView(
// //   scrollDirection: Axis.horizontal,
// //   child: DataTable(
// //     columns: <DataColumn>[
// //       DataColumn(label: Text("Nama")),
// //       DataColumn(label: Text("Instansi / Alamat")),
// //       DataColumn(label: Text("Menemui")),
// //       DataColumn(label: Text("Keperluan")),
// //       // DataColumn(label: Text("Tanggal / Waktu")),
// //       // DataColumn(label: Text("Tanda Tangan")),
// //       // DataColumn(label: Text("Foto")),
// //     ],
// //     rows: <DataRow>[
// //       DataRow(
// //           cells: <DataCell>[
// //             DataCell(Text(tamu.nama)),
// //             DataCell(Text(tamu.instansi)),
// //             DataCell(Text(tamu.menemui)),
// //             DataCell(Text(tamu.keperluan)),
// //             DataCell(Text(tamu.createDate)),
// //             DataCell(Text(tamu.imgTtd)),
// //             DataCell(Text(tamu.imgPhoto)),
// //           ],
// //       ),
// //       DataRow(
// //           cells: <DataCell>[
// //             DataCell(Text("Ice Cream Sandwich")),
// //             DataCell(Text("237")),
// //             DataCell(Text("9.0")),
// //             DataCell(Text("4.3")),
// //           ],
// //       ),
// //       DataRow(
// //           cells: <DataCell>[
// //             DataCell(Text("Eclair")),
// //             DataCell(Text("262")),
// //             DataCell(Text("16.0")),
// //             DataCell(Text("6.0")),
// //           ],
// //       ),
// //     ],
// //   ),
// // ),
