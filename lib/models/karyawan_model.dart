class KaryawanModel {
  String? gepdID;
  String? gepdName;
  String? epdID;
  String? epdName;
  String? branchID;
  String? memberID;
  String? memberName;

  KaryawanModel(
      {required this.gepdID,
      required this.gepdName,
      required this.epdID,
      required this.epdName,
      required this.branchID,
      required this.memberID,
      required this.memberName});

  factory KaryawanModel.fromJson(Map<String, dynamic> json) {
    return KaryawanModel(
      gepdID: json['rm_mst_gepd'] ?? "ID GEPD",
      gepdName: json['NamaGEPD'] ?? "Nama GEPD",
      epdID: json['rm_mst_epd'] ?? "ID EPD",
      epdName: json['NamaEPD'] ?? "Nama EPD",
      branchID: json['rm_branch_id'] ?? "ID Branch",
      memberID: json['rm_rep_id'] ?? "ID Member",
      memberName: json['rm_name'] ?? "Nama Member",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['rm_mst_gepd'] = this.gepdID;
    data['NamaGEPD'] = this.gepdName;
    data['rm_mst_epd'] = this.epdID;
    data['NamaEPD'] = this.epdName;
    data['rm_branch_id'] = this.branchID;
    data['rm_rep_id'] = this.memberID;
    data['rm_name'] = this.memberName;

    return data;
  }
}

class Karyawan {}
