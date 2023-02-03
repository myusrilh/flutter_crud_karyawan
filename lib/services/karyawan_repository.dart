import 'dart:async';
import 'dart:convert';
import 'package:crud_karyawan/helper/custom_data.dart';
import 'package:crud_karyawan/models/member_model.dart';
import 'package:http/http.dart' as http;

import 'package:crud_karyawan/models/karyawan_model.dart';

class KaryawanRepository {
  Future<List<KaryawanModel>> fetchDataKaryawan(String? managerID) async {
    http.Response response;
    if (managerID == null) {
      String endPointAllKaryawan = "karyawan/getAll";
      response = await http.get(Uri.parse(urlBase + "/" + endPointAllKaryawan));
    } else {
      String endPointByManagerID = "karyawan/getByManagerID";
      response = await http.post(Uri.parse(urlBase + "/" + endPointByManagerID),
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
        await http.get(Uri.parse(urlBase + "/" + endPointAllKaryawan));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      // print(result);
      return result.map((item) => MemberModel.fromJson(item)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<MemberModel>> fetchDataKaryawanByMemberID(
      String? memberID) async {
    http.Response response;

    String endPointByMemberID = "karyawan/getByRepID";
    response = await http.post(Uri.parse(urlBase + "/" + endPointByMemberID),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({"repID": memberID}));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((item) => MemberModel.fromJson(item)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<String> deleteMember(String rmRepID) async {
    String endPointDeleteKaryawan = "karyawan/deleteKaryawan/${rmRepID}";
    final response = await http.delete(
        Uri.parse(urlBase + "/" + endPointDeleteKaryawan),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      // print(result);
      return result['message'];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
