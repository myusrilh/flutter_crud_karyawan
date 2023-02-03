import 'dart:async';
import 'package:crud_karyawan/screen/authentication/sign_in.dart';
import 'package:crud_karyawan/screen/home_page.dart';
import 'package:crud_karyawan/services/karyawan_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/custom_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("logged_in")) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: ((context) => RepositoryProvider(
              create: (context) => KaryawanRepository(), child: HomePage()))));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => SignInPage())));
    }
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      checkLoggedIn();
    });
  }

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColorTheme,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Tigaraksa Satria".toUpperCase(),
            style: TextStyle(
                color: emeraldColorTheme,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
          Text(
            "Human Resources Management",
            style: TextStyle(
                color: emeraldColorTheme,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 90,
          ),
          SizedBox(
            width: 250,
            child: Image.asset('assets/images/company_logo.png'),
          ),
          SizedBox(
            height: 150,
          ),
          Text(
            "Copyright PT. Tigaraksa Satria \u00a9 2023",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: emeraldColorTheme),
          )
        ],
      )),
    );
  }
}
