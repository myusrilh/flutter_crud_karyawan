import 'dart:convert';

import 'package:crud_karyawan/helper/custom_data.dart';
import 'package:crud_karyawan/screen/home_page.dart';
import 'package:crud_karyawan/services/karyawan_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //key form log in

  var txtEditUsername = TextEditingController();
  var txtEditPassword = TextEditingController();

  // String urlBase = "http://localhost:3000/api/"; // default
  // String urlBase =
  //     "http://10.0.2.2:3000/api/"; // url server untuk AVD (bisa menggunakan 127.0.0.1:port juga)
  // String urlBase =
  //     "http://192.168.100.56:3000/api/"; // url server untuk HP fisik (bisa menggunakan 127.0.0.1:port juga)

  void saveSession(String username, String role) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("username", username);
    sharedPreferences.setString("role", role);
    sharedPreferences.setBool("logged_in", true);
  }

  void loginProcess(username, password) async {
    final GlobalKey<State> _keyLoader = GlobalKey<State>();
    String apiEndPoint = "user/login";

    try {
      final response = await http.post(Uri.parse(urlBase + "/" + apiEndPoint),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({"username": username, "password": password}));

      if (response.body.isNotEmpty) {
        final output = jsonDecode(response.body);
        String role = output["data"][0]["role"].toString();

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: Duration(milliseconds: 500),
                content: Text(
                  output['message'],
                  style: const TextStyle(fontSize: 16),
                )),
          );

          if (output['status'] == 'success') {
            saveSession(username, role);
          }

          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => HomePage())));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
              output['error'],
              style: const TextStyle(fontSize: 16),
            )),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            "Data tidak ada!\nAnda belum terdaftar.",
            style: const TextStyle(fontSize: 16),
          )),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          e.toString(),
          style: const TextStyle(fontSize: 16),
        )),
      );
      print(e.toString());
    }
  }

  void _validateInput() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Login process
      loginProcess(txtEditUsername.text, txtEditPassword.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColorTheme,
        body: Center(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 31, right: 31),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: txtEditUsername,
                    onSaved: (String? val) {
                      txtEditUsername.text = val!;
                    },
                    validator: (username) => username!.isEmpty
                        ? 'Username tidak boleh kosong!'
                        : null,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Masukkan Username',
                        hintStyle: TextStyle(
                            fontSize: 12.0, color: Colors.blueGrey[100]),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        label: Text(
                          'Username',
                          style: TextStyle(
                              color: emeraldColorTheme,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        focusColor: emeraldColorTheme,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: emeraldColorTheme, width: 1)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: emeraldColorTheme, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: emeraldColorTheme, width: 1))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: txtEditPassword,
                    onSaved: (String? val) {
                      txtEditPassword.text = val!;
                    },
                    validator: (password) => password!.isEmpty
                        ? 'Password tidak boleh kosong!'
                        : null,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: 'Masukkan Password',
                        hintStyle: TextStyle(
                            fontSize: 12.0, color: Colors.blueGrey[100]),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        label: Text(
                          'Password',
                          style: TextStyle(
                              color: emeraldColorTheme,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        focusColor: emeraldColorTheme,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: emeraldColorTheme, width: 1)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: emeraldColorTheme, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: emeraldColorTheme, width: 1))),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _validateInput();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(emeraldColorTheme)),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: whiteColorTheme,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ]),
          ),
        )));
  }
}
