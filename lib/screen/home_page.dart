import 'dart:io';

import 'package:crud_karyawan/helper/custom_theme.dart';
import 'package:crud_karyawan/models/karyawan_model.dart';
import 'package:crud_karyawan/models/member_model.dart';
import 'package:crud_karyawan/screen/appbar/default_app_bar.dart';
import 'package:crud_karyawan/screen/new_karyawan_page.dart';
import 'package:crud_karyawan/services/karyawan_repository.dart';

import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username;
  String? role;
  Future<String>? message;
  bool search = false;
  late List<KaryawanModel> allKaryawan;

  KaryawanRepository karyawanRepository = KaryawanRepository();
  String? dropDownValue;

  late Future<List<KaryawanModel>> futureKaryawanData;
  late Future<List<MemberModel>> futureManagerData;

  Future<List<KaryawanModel>> getKaryawan(String? managerID) async {
    return await karyawanRepository.fetchDataKaryawan(managerID);
  }

  Future<List<MemberModel>> getManager() async {
    return await karyawanRepository.fetchDataAllManager();
  }

  void getUsernameAndRoleFromSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      role = prefs.getString("role");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allKaryawan = [];
    futureKaryawanData = getKaryawan(null);
    futureManagerData = getManager();
    setState(() {
      getUsernameAndRoleFromSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(appBarTitle: "Tigaraksa Satria", isHomePage: true),
      backgroundColor: whiteColorTheme,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 30),
                child: Text("Username: ${username}"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("Role: ${role}"),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: FutureBuilder(
                    future: futureManagerData,
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        List<MemberModel> allManager = snapshot.data!;

                        return addManagerDropdown(allManager);
                      }
                      return Container();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    exportToExcelButton(allKaryawan),
                    tambahMemberButton(),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: FutureBuilder(
                      future: futureKaryawanData,
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          // setState(() {
                          allKaryawan = snapshot.data!;
                          // });

                          return tampilkanTabel(snapshot.data!);
                        }
                        return Container();
                      }),
                ),
              ),
              tampilSemuaDataButton(),
            ],
          ),
        ),
      ),
    );
  }

  void exportToExcelFunction(List<KaryawanModel> allKaryawan) {
    var excel = Excel.createExcel();
    var sheet = excel['Data Karyawan'];

    CellStyle cellStyle = CellStyle(
      bold: true,
      italic: true,
      textWrapping: TextWrapping.WrapText,
      fontFamily: getFontFamily(FontFamily.Futura),
      rotation: 0,
    );

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        "No";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
        .cellStyle = cellStyle;
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
        "rm_mst_gepd";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0))
        .cellStyle = cellStyle;
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
        "NamaGEPD";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0))
        .cellStyle = cellStyle;
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
        "rm_mst_epd";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0))
        .cellStyle = cellStyle;
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value =
        "NamaEPD";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0))
        .cellStyle = cellStyle;
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0)).value =
        "rm_branch_id";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0))
        .cellStyle = cellStyle;
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0)).value =
        "rm_name";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0))
        .cellStyle = cellStyle;

    for (var i = 0; i < allKaryawan.length; i++) {
      int rowIndex = i + 1;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex))
          .value = rowIndex;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex))
          .value = allKaryawan[i].gepdID;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex))
          .value = allKaryawan[i].gepdName;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex))
          .value = allKaryawan[i].epdID;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex))
          .value = allKaryawan[i].epdName;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: rowIndex))
          .value = allKaryawan[i].branchID;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: rowIndex))
          .value = allKaryawan[i].memberName;
    }

    for (var table in excel.tables.keys) {
      print(table);
      print(excel.tables[table]!.maxCols);
      print(excel.tables[table]!.maxRows);
      print("${excel.tables[table]!.rows}");
      for (var row in excel.tables[table]!.rows) {
        print("${row}");
      }
    }

    saveToExcel(excel).whenComplete(() => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text("Excel berhasil tersimpan!"))));
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(int version) async {
    final path = await _localPath;
    print(path);

    return File(
        '$path/data_karyawan_v-${version}.xlsx'); //jika sudah terinstall dalam bentuk APK?
    // return File('/storage/0/emulated/Download/data_karyawan_v-${version}.xlsx');
  }

  Future<File> saveToExcel(Excel excel) async {
    final file = await _localFile(1);

    var fileBytes = excel.save();

    // Write the file
    return file.writeAsBytes(fileBytes!);
  }

  Widget exportToExcelButton(List<KaryawanModel> allKaryawan) {
    return SizedBox(
      width: 130,
      height: 30,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: Text("Export ke Excel")));

          exportToExcelFunction(allKaryawan);
        },
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)),
        child: Text(
          'Export Excel',
          style: TextStyle(
              color: Colors.black, fontSize: 10, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget addManagerDropdown(List<MemberModel> allManager) {
    if (allManager.length > 0) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 5),
            child: Text(
              "Pilih Manager:",
              style: TextStyle(fontSize: 12),
            ),
          ),
          DropdownButton(
            hint: Text(
              "Daftar Manager",
              style: TextStyle(fontSize: 12),
            ),
            value: dropDownValue,
            underline: Container(
              height: 2,
              color: emeraldColorTheme,
            ),
            items: allManager.asMap().entries.map((item) {
              return DropdownMenuItem(
                child: Text(
                  item.value.rmName.toString(),
                  style: TextStyle(fontSize: 12),
                ),
                value: item.value.rmRepID,
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                dropDownValue = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: 80,
              height: 30,
              child: ElevatedButton(
                onPressed: dropDownValue != null
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text("Cari Data")));
                        setState(() {
                          search = true;
                          futureKaryawanData = getKaryawan(dropDownValue);
                        });
                      }
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text(
                                "Pilih manager pada dropdown terlebih dahulu")));
                      },
                style: ButtonStyle(
                    backgroundColor: dropDownValue != null
                        ? MaterialStatePropertyAll<Color>(Colors.cyan)
                        : MaterialStatePropertyAll<Color>(Colors.grey)),
                child: Text(
                  'Cari Data',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Container();
  }

  Widget tambahMemberButton() {
    if (role == "administrator") {
      return Padding(
        padding: const EdgeInsets.only(left: 5),
        child: SizedBox(
          width: 120,
          height: 30,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TambahKaryawanPage()));
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(createDataButton)),
            child: Text(
              'Tambah Member',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      );
    }
    return Container();
  }

  Widget tampilSemuaDataButton() {
    return search
        ? SizedBox(
            width: 130,
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text("Tampilkan semua data")));
                setState(() {
                  search = false;
                  dropDownValue = null;
                  futureKaryawanData = getKaryawan(null);
                });
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(emeraldColorTheme)),
              child: Text(
                'Semua data',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        : Container();
  }

  Widget tampilkanTabel(List<KaryawanModel> allKaryawanList) {
    if (role == "administrator") {
      return DataTable(
          columns: [
            DataColumn(
                label: Text(
              "rm_mst_gepd",
              style: TextStyle(fontWeight: FontWeight.w600),
            )),
            DataColumn(
                label: Text("NamaGEPD",
                    style: TextStyle(fontWeight: FontWeight.w600))),
            DataColumn(
                label: Text("rm_mst_epd",
                    style: TextStyle(fontWeight: FontWeight.w600))),
            DataColumn(
                label: Text("NamaEPD",
                    style: TextStyle(fontWeight: FontWeight.w600))),
            DataColumn(
                label: Text("rm_branch_id",
                    style: TextStyle(fontWeight: FontWeight.w600))),
            DataColumn(
                label: Text("rm_name",
                    style: TextStyle(fontWeight: FontWeight.w600))),
            DataColumn(
                label: Text("opsi",
                    style: TextStyle(fontWeight: FontWeight.w600))),
          ],
          rows: allKaryawanList
              .asMap()
              .entries
              .map((karyawan) => DataRow(cells: [
                    DataCell(Container(
                      child: Text(karyawan.value.gepdID.toString()),
                    )),
                    DataCell(Container(
                      child: Text(karyawan.value.gepdName.toString()),
                    )),
                    DataCell(Container(
                      child: Text(karyawan.value.epdID.toString()),
                    )),
                    DataCell(Container(
                      child: Text(karyawan.value.epdName.toString()),
                    )),
                    DataCell(Container(
                      child: Text(karyawan.value.branchID.toString()),
                    )),
                    DataCell(Container(
                      child: Text(karyawan.value.memberName.toString()),
                    )),
                    DataCell(
                      Container(
                          child: Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Ubah",
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.yellow))),
                          SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  message = KaryawanRepository()
                                      .deleteMember(karyawan.value.memberID!);
                                  allKaryawanList.removeAt(karyawan.key);
                                });
                              },
                              child: Text("Hapus",
                                  style: TextStyle(color: Colors.black)),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.red))),
                        ],
                      )),
                    ),
                  ]))
              .toList());
    } else {
      return DataTable(
          columns: [
            DataColumn(
                label: Text(
              "rm_mst_gepd",
              style: TextStyle(fontWeight: FontWeight.w600),
            )),
            DataColumn(
                label: Text("NamaGEPD",
                    style: TextStyle(fontWeight: FontWeight.w600))),
            DataColumn(
                label: Text("rm_mst_epd",
                    style: TextStyle(fontWeight: FontWeight.w600))),
            DataColumn(
                label: Text("NamaEPD",
                    style: TextStyle(fontWeight: FontWeight.w600))),
            DataColumn(
                label: Text("rm_branch_id",
                    style: TextStyle(fontWeight: FontWeight.w600))),
            DataColumn(
                label: Text("rm_name",
                    style: TextStyle(fontWeight: FontWeight.w600)))
          ],
          rows: allKaryawanList
              .asMap()
              .entries
              .map((karyawan) => DataRow(cells: [
                    DataCell(Container(
                      child: Text(karyawan.value.gepdID.toString()),
                    )),
                    DataCell(Container(
                      child: Text(karyawan.value.gepdName.toString()),
                    )),
                    DataCell(Container(
                      child: Text(karyawan.value.epdID.toString()),
                    )),
                    DataCell(Container(
                      child: Text(karyawan.value.epdName.toString()),
                    )),
                    DataCell(Container(
                      child: Text(karyawan.value.branchID.toString()),
                    )),
                    DataCell(Container(
                      child: Text(karyawan.value.memberName.toString()),
                    ))
                  ]))
              .toList());
    }
  }
}
