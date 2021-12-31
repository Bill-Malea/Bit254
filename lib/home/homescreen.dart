import 'package:bit254/Screens/Menu/Notifications.dart';
import 'package:bit254/Screens/Menu/Profile.dart';
import 'package:bit254/Screens/Menu/Widgets/Menu.dart';
import 'package:bit254/Screens/Menu/settings.dart';
import 'package:bit254/home/home.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:animated_drawer/views/animated_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bit254/Utilities/adaptive_size.dart';
import 'package:bit254/Utilities/colors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'Dashboard/Transactions_List/BTC/provider_bitcointransactions.dart';
import 'Dashboard/Transactions_List/ETHERIUM/Etheriumtransactio_list.dart';
import 'Dashboard/Transactions_List/mpesa/provider_mpesatransactionlist.dart';

class HOMESCREEN extends StatefulWidget {
  const HOMESCREEN({Key? key}) : super(key: key);

  @override
  _HOMESCREENState createState() => _HOMESCREENState();
}

class _HOMESCREENState extends State<HOMESCREEN> {
 
 GetStorage _prefs = GetStorage();
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    String _phone = _prefs.read('phone$uid');
    String _username = _prefs.read('username$uid');
    String _email = _prefs.read('email$uid');
    return AnimatedDrawer(
        homePageXValue: 150,
        homePageYValue: 80,
        homePageAngle: -0.2,
        homePageSpeed: 250,
        shadowXValue: 122,
        shadowYValue: 110,
        shadowAngle: -0.275,
        shadowSpeed: 250,
        openIcon: Icon(
          Icons.menu,
        ),
        closeIcon: Icon(
          Icons.arrow_back_ios,
        ),
        shadowColor: kSuccessColor,
        backgroundGradient: LinearGradient(colors: [
          Colors.black.withBlue(20),
          Colors.black.withBlue(30)
          // Color.fromRGBO(39, 50, 80, 1),
          // Color.fromRGBO(55, 66, 92, 0.4),
        ]),
        menuPageContent: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0, left: 15),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 350.0.h,
                  ),
                  Menubar(
                    header: "Profile",
                    icon: Icons.person,
                    nav: Profile(
                      _username,
                      _email,
                      _phone,
                      '',
                    ),
                    islogout: false,
                  ),
                  Divider(
                    color: kSuccessColor,
                  ),
                  Menubar(
                    header: "Notifications",
                    icon: Icons.notifications,
                    nav: Notifications(),
                    islogout: false,
                  ),
                  Divider(
                    color: kSuccessColor,
                  ),
                  Menubar(
                    header: "Settings",
                    icon: Icons.settings,
                    nav: Settings(),
                    islogout: false,
                  ),
                  Divider(
                    color: kSuccessColor,
                  ),
                  Menubar(
                    header: "Contact Support",
                    icon: Icons.phone,
                    nav: Settings(),
                    islogout: false,
                  ),
                  Divider(
                    color: kSuccessColor,
                  ),
                  Menubar(
                    header: "Log Out",
                    icon: Icons.exit_to_app,
                    islogout: true,
                    nav: null,
                  ),
                  Divider(
                    color: kSuccessColor,
                  ),
                ],
              ),
            ),
          ),
        ),

        ////////
        homePageContent: HomePage());
  }
}
