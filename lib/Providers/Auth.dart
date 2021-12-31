import 'package:bit254/Utilities/colors.dart';
import 'package:bit254/home/Restore_wallet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:get_storage/get_storage.dart';

var _didauth;

bool get didauth {
  return _didauth;
}

Future<void> auth({required BuildContext context}) async {
  GetStorage prefs = GetStorage();

  final LocalAuthentication auth = LocalAuthentication();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  bool _notifybmt = prefs.read('_bmt$uid');
  try {
    if (_notifybmt == true) {
      bool _didauthenticate = await auth.authenticate(
          biometricOnly: true,
          stickyAuth: true,
          localizedReason: 'Scan To Authenticate',
          androidAuthStrings: const AndroidAuthMessages(
              cancelButton: 'USE PIN',
              goToSettingsButton: 'ENROLL FINGERPRINT'));

      _didauth = _didauthenticate;
      if (_didauthenticate == true) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              Future.delayed(Duration(seconds: 5), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CreateWallet();

                      /// HOMESCREEN();
                    },
                  ),
                );
              });
              return AlertDialog(
                actions: <Widget>[
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
                          strokeWidth: 2.0,
                          color: kSuccessColor,
                        ),
                        SizedBox(width: 15),
                        const Text('Decrypting Wallet...'),
                      ],
                    ),
                  ),
                ],
              );
            });
      }
    } else {}
  } catch (error) {
    print('Finger Print $error');
  }
}
