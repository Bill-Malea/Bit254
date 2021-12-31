import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mpesa/mpesa.dart';

class Mpesatransactionlist with ChangeNotifier {
  List<MpesaTransaction> _mpesatransactions = [];
  List<MpesaTransaction> get mpestransactionlist {
    return [..._mpesatransactions];
  }

  Future<void> getmpesatransactions() async {
    final _user = FirebaseAuth.instance.currentUser!.uid;

    final url = Uri.parse(
      'https://test-d905a-default-rtdb.firebaseio.com/Mpesa/$_user.json',
    );
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var _fetchedmpesatransaction = json.decode(response.body) as dynamic;

        List<MpesaTransaction> _transaction = [];

        _fetchedmpesatransaction.forEach((id, transactionmap) {
          print(transactionmap['Body']['stkCallback']['ResultCode']);

          var _items = transactionmap['Body']['stkCallback']['CallbackMetadata']
              ['Item'] as List;

          var _id = _items[1]['Value'].toString();
          var _statuscode =
              transactionmap['Body']['stkCallback']['ResultCode'].toString();
          var _amount = _items[0]['Value'].toString();
          var _date = _items[3]['Value'].toString();

          if (_statuscode == '0')
            _transaction.add(MpesaTransaction(
              id: _id,
              statuscode: _statuscode,
              amount: _amount, // _amount,
              date: _date,
            ));
        });

        _mpesatransactions = _transaction;

        notifyListeners();
      }
    } catch (error) {
      print('Get mpesaa$error');
    }
  }

  Future<MpesaResponse> initiatepayment() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final _mpesa = Mpesa(
      environment: 'sandbox',
      passKey:
          "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
      clientKey: "OBjOaunSAchhYKM6mB7helT36Slg1grw",
      clientSecret: "WCcbntBI1Di9txIa",
    );

    var response = await _mpesa.lipaNaMpesa(
      businessShortCode: '174379',
      phoneNumber: '254727800223',
      amount: 1.0, // amount.
      accountReference: '0727800223',
      transactionType: 'CustomerPayBillOnline',
      callbackUrl:
          'https://test-d905a-default-rtdb.firebaseio.com/Mpesa/$uid.json',
    );
    var _response = response;
    print('Mpesa $_response hfhfhfh');
    getmpesatransactions();
    return response;
  }
}

class MpesaTransaction {
  final String id;
  final String statuscode;
  final String amount;
  final String date;

  MpesaTransaction({
    required this.id,
    required this.statuscode,
    required this.amount,
    required this.date,
  });
}
