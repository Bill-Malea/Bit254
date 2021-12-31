import 'package:bit254/home/homescreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bit254/Utilities/colors.dart';
import 'package:bit254/home/Dashboard/Transactions_List/BTC/provider_bitcointransactions.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:dartsv/dartsv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class CreateWallet extends StatelessWidget {
  final _prefs = GetStorage();
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Manage Wallet',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        elevation: 7,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<BTCProvider>(context, listen: false)
                          .createwallet(context);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            color: kSuccessColor,
                          )),
                      child: Row(children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.add,
                          color: kSuccessColor,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Create Wallet',
                          style: TextStyle(
                            color: kSuccessColor,
                            fontSize: 12,
                          ),
                        )
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            color: kSuccessColor,
                          )),
                      child: Row(children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.downloading_rounded,
                          color: kSuccessColor,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Restore Wallet',
                          style: TextStyle(
                            color: kSuccessColor,
                            fontSize: 12,
                          ),
                        )
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Tip!. Restoring an existing wallet enables the user to access a previously created account by providing a 12 word mnemonic issued upon creation of an account. Creating an account provides a user with 12 word mnemonic which should be stored offline It enables the user recover their funds if their phone is lost ',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
