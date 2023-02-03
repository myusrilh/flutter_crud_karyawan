// if (role == "administrator") {
    // return DataTable(
    //     columns: [
    //       DataColumn(
    //           label: Text(
    //         "rm_mst_gepd",
    //         style: TextStyle(fontWeight: FontWeight.w600),
    //       )),
    //       DataColumn(
    //           label: Text("NamaGEPD",
    //               style: TextStyle(fontWeight: FontWeight.w600))),
    //       DataColumn(
    //           label: Text("rm_mst_epd",
    //               style: TextStyle(fontWeight: FontWeight.w600))),
    //       DataColumn(
    //           label: Text("NamaEPD",
    //               style: TextStyle(fontWeight: FontWeight.w600))),
    //       DataColumn(
    //           label: Text("rm_branch_id",
    //               style: TextStyle(fontWeight: FontWeight.w600))),
    //       DataColumn(
    //           label: Text("rm_name",
    //               style: TextStyle(fontWeight: FontWeight.w600))),
    //       DataColumn(
    //           label: Text("opsi",
    //               style: TextStyle(fontWeight: FontWeight.w600))),
    //     ],
    //     rows: allKaryawanList
    //         .asMap()
    //         .entries
    //         .map((karyawan) => DataRow(cells: [
    //               DataCell(Container(
    //                 child: Text(karyawan.value.gepdID.toString()),
    //               )),
    //               DataCell(Container(
    //                 child: Text(karyawan.value.gepdName.toString()),
    //               )),
    //               DataCell(Container(
    //                 child: Text(karyawan.value.epdID.toString()),
    //               )),
    //               DataCell(Container(
    //                 child: Text(karyawan.value.epdName.toString()),
    //               )),
    //               DataCell(Container(
    //                 child: Text(karyawan.value.branchID.toString()),
    //               )),
    //               DataCell(Container(
    //                 child: Text(karyawan.value.memberName.toString()),
    //               )),
    //               DataCell(
    //                 Container(
    //                     child: Row(
    //                   children: [
    //                     ElevatedButton(
    //                         onPressed: () {},
    //                         child: Text(
    //                           "Ubah",
    //                           style: TextStyle(color: Colors.black),
    //                         ),
    //                         style: ButtonStyle(
    //                             backgroundColor:
    //                                 MaterialStatePropertyAll<Color>(
    //                                     Colors.yellow))),
    //                     SizedBox(
    //                       width: 5,
    //                     ),
    //                     ElevatedButton(
    //                         onPressed: () {
    //                           setState(() {
    //                             message = KaryawanRepository().deleteMember(
    //                                 karyawan.value.memberID.toString());
    //                             allKaryawanList.removeAt(karyawan.key);
    //                           });
    //                         },
    //                         child: Text("Hapus",
    //                             style: TextStyle(color: Colors.black)),
    //                         style: ButtonStyle(
    //                             backgroundColor:
    //                                 MaterialStatePropertyAll<Color>(
    //                                     Colors.red))),
    //                   ],
    //                 )),
    //               ),
    //             ]))
    //         .toList());
    // } else {
    // return DataTable(
    //     columns: [
    //       DataColumn(
    //           label: Text(
    //         "rm_mst_gepd",
    //         style: TextStyle(fontWeight: FontWeight.w600),
    //       )),
    //       DataColumn(
    //           label: Text("NamaGEPD",
    //               style: TextStyle(fontWeight: FontWeight.w600))),
    //       DataColumn(
    //           label: Text("rm_mst_epd",
    //               style: TextStyle(fontWeight: FontWeight.w600))),
    //       DataColumn(
    //           label: Text("NamaEPD",
    //               style: TextStyle(fontWeight: FontWeight.w600))),
    //       DataColumn(
    //           label: Text("rm_branch_id",
    //               style: TextStyle(fontWeight: FontWeight.w600))),
    //       DataColumn(
    //           label: Text("rm_name",
    //               style: TextStyle(fontWeight: FontWeight.w600)))
    //     ],
    //     rows: allKaryawanList
    //         .asMap()
    //         .entries
    //         .map((karyawan) => DataRow(cells: [
    //               DataCell(Container(
    //                 child: Text(karyawan.value.gepdID.toString()),
    //               )),
    //               DataCell(Container(
    //                 child: Text(karyawan.value.gepdName.toString()),
    //               )),
    //               DataCell(Container(
    //                 child: Text(karyawan.value.epdID.toString()),
    //               )),
    //               DataCell(Container(
    //                 child: Text(karyawan.value.epdName.toString()),
    //               )),
    //               DataCell(Container(
    //                 child: Text(karyawan.value.branchID.toString()),
    //               )),
    //               DataCell(Container(
    //                 child: Text(karyawan.value.memberName.toString()),
    //               ))
    //             ]))
    //         .toList());
    // }

    