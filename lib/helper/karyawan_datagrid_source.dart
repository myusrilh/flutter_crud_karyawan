import 'package:crud_karyawan/models/karyawan_model.dart';
import 'package:flutter/cupertino.dart';

// class KaryawanDatGridSource extends DataGridSource {
//   KaryawanDatGridSource(List<KaryawanModel>? karyawanPassed) {
//     this.karyawan = karyawanPassed!;
//     buildDataGridRow();
//   }

//   void buildDataGridRow() {
//     _karyawanDataGridRows = karyawan
//         .map((item) => DataGridRow(cells: [
//               DataGridCell(columnName: "rm_mst_gepd", value: item.gepdID),
//               DataGridCell(columnName: "NamaGEPD", value: item.gepdName),
//               DataGridCell(columnName: "rm_mst_epd", value: item.epdID),
//               DataGridCell(columnName: "NamaEPD", value: item.epdName),
//               DataGridCell(columnName: "rm_branch_id", value: item.branchID),
//               DataGridCell(columnName: "rm_name", value: item.memberName),
//             ]))
//         .toList();
//   }

//   List<KaryawanModel> karyawan = [];

//   List<DataGridRow> _karyawanDataGridRows = [];

//   @override
//   List<DataGridRow> get rows => _karyawanDataGridRows;

//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((dataGridCell) {
//       return Container(
//         width: 20,
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(5.0),
//         child: Text(dataGridCell.value.toString()),
//       );
//     }).toList());
//   }

//   void updateDataGrid() {
//     notifyListeners();
//   }
// }
