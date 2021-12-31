import 'package:bit254/Utilities/colors.dart';
import 'package:bit254/home/Dashboard/Transactions_List/BTC/provider_bitcointransactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class AccountBalance extends StatefulWidget {
  @override
  _AccountBalanceState createState() => _AccountBalanceState();
}

class _AccountBalanceState extends State<AccountBalance> {
var uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    GetStorage _prefs = GetStorage();
    
    String _firstName = _prefs.read('firstname$uid')[0];
    String _lastName = _prefs.read('lastname$uid')[1];
    var _accountbalance = Provider.of<BTCProvider>(context).btcbalance;
    print('this is balance $_accountbalance');
    ThemeData themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Wallet Balance",
                style: themeData.textTheme.caption,
              ),
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kSuccessColor,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                    child: Text(
                  '${_firstName.substring(0)}' +
                      '${_lastName.substring(0)}', //   _name[0].toUpperCase() +
                  //          _name.split(" ").last[0].toUpperCase(),
                  style: TextStyle(
                    color: kSuccessColor,
                    fontSize: 17,
                  ),
                )),
              ),
            ],
          ),
          SizedBox(
            height: 6.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\Ksh $_accountbalance",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
          ),
          Row(
            children: [
              Text(
                "+2.14%",
                style: TextStyle(
                  color: kSuccessColor,
                  fontSize: 16.0,
                ),
              ),
              Icon(
                FlutterIcons.caret_up_faw,
                color: kSuccessColor,
              )
            ],
          )
        ],
      ),
    );
  }
}
