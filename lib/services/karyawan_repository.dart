import 'dart:async';
import 'dart:convert';
import 'package:crud_karyawan/models/member_model.dart';
import 'package:http/http.dart' as http;

import 'package:crud_karyawan/models/karyawan_model.dart';

class KaryawanRepository {
  // String baseUrl = "http://10.0.2.2:3000/api"; // untuk AVD
  String baseUrl = "http://192.168.100.56:3000/api"; // untuk hp fisik

  Future<List<KaryawanModel>> fetchDataKaryawan(String? managerID) async {
    http.Response response;
    if (managerID == null) {
      String endPointAllKaryawan = "karyawan/getAll";
      response = await http.get(Uri.parse(baseUrl + "/" + endPointAllKaryawan));
    } else {
      String endPointByManagerID = "karyawan/getByManagerID";
      response = await http.post(Uri.parse(baseUrl + "/" + endPointByManagerID),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({"managerID": managerID}));
    }

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((item) => KaryawanModel.fromJson(item)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<MemberModel>> fetchDataAllManager() async {
    String endPointAllKaryawan = "karyawan/getManager";
    final response =
        await http.get(Uri.parse(baseUrl + "/" + endPointAllKaryawan));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      print(result);
      return result.map((item) => MemberModel.fromJson(item)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  insertNewMember(MemberModel memberModel) async {}

  Future<String> deleteMember(String rmRepID) async {
    String endPointDeleteKaryawan = "karyawan/deleteKaryawan/${rmRepID}";
    final response = await http.delete(
        Uri.parse(baseUrl + "/" + endPointDeleteKaryawan),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print(result);
      return result['message'];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
