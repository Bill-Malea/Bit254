import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bit254/Utilities/colors.dart';
import 'package:get_storage/get_storage.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    GetStorage _prefs = GetStorage();
    bool _psnvalue = _prefs.read('_pushnotifications$uid') == null
        ? false
        : _prefs.read('_pushnotifications$uid');
    bool _bmtvalue = _prefs.read('_biometrics$uid') == null
        ? false
        : _prefs.read('_biometrics$uid');
    bool _bcwvalue = _prefs.read('_backupwallet$uid') == null
        ? false
        : _prefs.read('_backupwallet$uid');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "SETTINGS",
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 7,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Preferences',
                style: TextStyle(
                  color: kCaptionColor,
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Push Notifications',
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Switch(
                    activeColor: kSuccessColor,
                    inactiveThumbColor: kSuccessColor,
                    value: _psnvalue,
                    onChanged: (bool newValue) async {
                      setState(() {
                        _prefs.write('_pushnotifications$uid', newValue);
                        _psnvalue = newValue;
                      });
                    },
                  )
                ],
              ),
            ),
            Divider(
              color: Color.fromRGBO(97, 99, 119, 1),
            ),
            Settingwidg(
              'Change Pin ',
            ),
            Divider(
              color: Color.fromRGBO(97, 99, 119, 1),
            ),
            Settingwidg(
              'Change Password ',
            ),
            Divider(
              color: Color.fromRGBO(97, 99, 119, 1),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Biometric Unlock',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Switch(
                      activeColor: kSuccessColor,
                      inactiveThumbColor: kSuccessColor,
                      value: _bmtvalue,
                      onChanged: (bool newValue) async {
                        setState(() {
                          _prefs.write('_biometrics$uid', newValue);
                          _bmtvalue = newValue;
                        });
                      }),
                ],
              ),
            ),
            Divider(
              color: Color.fromRGBO(97, 99, 119, 1),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Backup Wallet',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Switch(
                    activeColor: kSuccessColor,
                    inactiveThumbColor: kSuccessColor,
                    value: _bcwvalue,
                    onChanged: (bool newValue) async {
                      setState(
                        () {
                          _prefs.write('_backupwallet$uid', newValue);
                          _bcwvalue = newValue;
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                ' Wallet',
                style: TextStyle(
                  color: kCaptionColor,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Settingwidg(
              'About Us ',
            ),
            Divider(
              color: Color.fromRGBO(97, 99, 119, 1),
            ),
            Settingwidg(
              'FAQ',
            ),
            Divider(
              color: Color.fromRGBO(97, 99, 119, 1),
            ),
            Settingwidg(
              'Privacy Policy',
            ),
            Divider(
              color: Color.fromRGBO(97, 99, 119, 1),
            ),
            Settingwidg(
              'Terms Of Service',
            ),
            Divider(
              color: Color.fromRGBO(97, 99, 119, 1),
            ),
          ],
        ),
      ),
    );
  }
}

class Settingwidg extends StatelessWidget {
  final String name;
  const Settingwidg(
    this.name,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(
          bottom: 15,
          right: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              name,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: kSuccessColor,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
