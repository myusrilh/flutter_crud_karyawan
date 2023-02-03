import 'package:crud_karyawan/helper/custom_data.dart';
import 'package:crud_karyawan/screen/authentication/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  DefaultAppBar({Key? key, this.appBarTitle, this.isHomePage})
      : super(key: key);

  String? appBarTitle;
  bool? isHomePage;

  @override
  State<DefaultAppBar> createState() =>
      _DefaultAppBarState(appBarTitle, isHomePage);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  _DefaultAppBarState(this.titleBar, this.isHomePage);

  String? titleBar;
  bool? isHomePage;

  void destroySession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove("username");
      prefs.remove("role");
      prefs.remove("logged_in");
    });

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => SignInPage())));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: isHomePage! ? false : true,
      centerTitle: true,
      backgroundColor: emeraldColorTheme,
      leading: isHomePage!
          ? InkWell(
              child: Icon(Icons.person),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Anda menekan foto profil"))),
            )
          : null,
      title: Text(
        titleBar!,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              destroySession();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text("Berhasil logout")));
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(whiteColorTheme)),
            child: Text(
              'Logout',
              style: TextStyle(
                  color: emeraldColorTheme,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
