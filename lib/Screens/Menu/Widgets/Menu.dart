import 'package:bit254/Utilities/adaptive_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menubar extends StatelessWidget {
  final String header;
  final IconData icon;
  final bool islogout;
  final Widget? nav;
  Menubar(
      {required this.header,
      required this.icon,
      this.nav,
      required this.islogout});

  final FirebaseAuth _fbauth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Future<void> _signout() async {
      await _fbauth.signOut();
      Navigator.of(context).pop();
    }

    return InkWell(
      onTap: () {
        islogout
            ? _signout()
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return nav!;
                  },
                ),
              );
      },
      child: SizedBox(
        width: 130.0.w,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              header,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
