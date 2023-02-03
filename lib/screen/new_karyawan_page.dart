import 'package:crud_karyawan/helper/custom_theme.dart';
import 'package:crud_karyawan/models/member_model.dart';
import 'package:crud_karyawan/screen/appbar/default_app_bar.dart';
import 'package:crud_karyawan/services/karyawan_repository.dart';
import 'package:flutter/material.dart';

class TambahKaryawanPage extends StatefulWidget {
  const TambahKaryawanPage({super.key});

  @override
  State<TambahKaryawanPage> createState() => _TambahKaryawanPageState();
}

class _TambahKaryawanPageState extends State<TambahKaryawanPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? dropDownValue;

  KaryawanRepository karyawanRepository = KaryawanRepository();
  late Future<List<MemberModel>> futureManagerData;
  Future<List<MemberModel>> getManager() async {
    return await karyawanRepository.fetchDataAllManager();
  }

  @override
  void initState() {
    // TODO: implement initState
    futureManagerData = getManager();
    super.initState();
  }

  void _validateInput() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  var txtEditBranchID = TextEditingController();
  var txtEditMemberID = TextEditingController();
  var txtEditMemberName = TextEditingController();
  var txtEditCurrentPosition = TextEditingController(text: "EPC");
  var txtEditManagerID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        appBarTitle: "Tambah Member",
        isHomePage: false,
      ),
      backgroundColor: whiteColorTheme,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 15),
                      child: TextFormField(
                        controller: txtEditBranchID,
                        onSaved: (String? val) {
                          txtEditBranchID.text = val!;
                        },
                        style: TextStyle(fontSize: 12),
                        validator: (branchid) => branchid!.isEmpty
                            ? 'Branch ID tidak boleh kosong!'
                            : null,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Masukkan Branch ID',
                            hintStyle: TextStyle(
                                fontSize: 12.0, color: Colors.blueGrey[100]),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 2),
                            label: Text(
                              'Branch ID',
                              style: TextStyle(
                                  color: emeraldColorTheme,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            focusColor: emeraldColorTheme,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: emeraldColorTheme, width: 1)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: emeraldColorTheme, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: emeraldColorTheme, width: 1))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextFormField(
                        controller: txtEditMemberID,
                        style: TextStyle(fontSize: 12),
                        onSaved: (String? val) {
                          txtEditBranchID.text = val!;
                        },
                        validator: (value) => value!.isEmpty
                            ? 'Member ID tidak boleh kosong!'
                            : null,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Masukkan Member ID',
                            hintStyle: TextStyle(
                                fontSize: 12.0, color: Colors.blueGrey[100]),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 2),
                            label: Text(
                              'Member ID',
                              style: TextStyle(
                                  color: emeraldColorTheme,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            focusColor: emeraldColorTheme,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: emeraldColorTheme, width: 1)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: emeraldColorTheme, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: emeraldColorTheme, width: 1))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextFormField(
                        controller: txtEditMemberName,
                        style: TextStyle(fontSize: 12),
                        onSaved: (String? val) {
                          txtEditBranchID.text = val!;
                        },
                        validator: (value) => value!.isEmpty
                            ? 'Nama member tidak boleh kosong!'
                            : null,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Masukkan nama member',
                            hintStyle: TextStyle(
                                fontSize: 12.0, color: Colors.blueGrey[100]),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 2),
                            label: Text(
                              'Nama Member',
                              style: TextStyle(
                                  color: emeraldColorTheme,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            focusColor: emeraldColorTheme,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: emeraldColorTheme, width: 1)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: emeraldColorTheme, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: emeraldColorTheme, width: 1))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextFormField(
                        style: TextStyle(fontSize: 12),
                        controller: txtEditCurrentPosition,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 2),
                            label: Text(
                              'Current Position',
                              style: TextStyle(
                                  color: emeraldColorTheme,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            focusColor: emeraldColorTheme,
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: emeraldColorTheme, width: 1)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: emeraldColorTheme, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: emeraldColorTheme, width: 1))),
                      ),
                    ),
                    FutureBuilder(
                      future: futureManagerData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<MemberModel> allManager = snapshot.data!;
                          return DropdownButtonFormField(
                            validator: (value) => value == null
                                ? "Manager tidak boleh kosong"
                                : null,
                            style: TextStyle(fontSize: 12),
                            hint: Text(
                              "Daftar Manager",
                              style: TextStyle(fontSize: 12),
                            ),
                            value: dropDownValue,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 2),
                                label: Text(
                                  'Manager',
                                  style: TextStyle(
                                      color: emeraldColorTheme,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                focusColor: emeraldColorTheme,
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: emeraldColorTheme, width: 1)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: emeraldColorTheme, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: emeraldColorTheme, width: 1))),
                            items: allManager.asMap().entries.map((item) {
                              return DropdownMenuItem(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration: Duration(milliseconds: 500),
                                          content: Text(
                                              "${item.value.rmName} Clicked")));
                                },
                                child: Text(
                                  item.value.rmName.toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                                value: item.value.rmRepID,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                dropDownValue = value;
                              });
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(children: [
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text("Submit Button")));
                            _validateInput();
                            setState(() {});
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.blueAccent)),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //     duration: Duration(seconds: 1),
                            //     content: Text("Cancel Button")));
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.red)),
                          child: Text(
                            'Batal',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ]),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
