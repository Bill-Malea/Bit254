import 'dart:convert';
import 'package:bip32/bip32.dart' as bip32;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:intl/intl.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'dart:typed_data';
import 'package:crypto/crypto.dart' as crypto;
import '../../../homescreen.dart';

class BTCProvider with ChangeNotifier {
  final _prefs = GetStorage();
  final _uid = FirebaseAuth.instance.currentUser!.uid;

//String toSign = txSkel['tosign'][0];

  String _btcPrice = '';
  String get btcPrice {
    return _btcPrice;
  }

  String get btcbalance {
    var _format =
        NumberFormat.currency(locale: "en US", symbol: "", decimalDigits: 0);
    var _addressbalance = _prefs.read(
      '_walletbalance$_uid',
    );

    var _amount = _format.format(
        ((_addressbalance == null ? 0 : _addressbalance) *
            (btcPrice.isEmpty ? 0 : double.tryParse(btcPrice))));

    return _amount;
  }

  List<CandleData> _candles = [];

  List<CandleData> get btcCandles {
    return [..._candles];
  }

  Future<void> getBTCaccountbalance(String address) async {
    try {
      final url = Uri.parse(
          'https://api.blockcypher.com/v1/bcy/test/addrs/$address/balance');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var _data = json.decode(response.body) as dynamic;
        var _price =
            (_data['total_received'] / 100000000) * double.tryParse(btcPrice);
        _prefs.write('_walletbalance$_uid', _price);

        notifyListeners();
      } else {
        print(response.statusCode);
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> getBTCprice() async {
    var _accountbalance = await _prefs.read(
      '_walletbalance$_uid',
    );
    var _address = await _prefs.read(
      '_address$_uid',
    );

    if (_accountbalance == null) {
      getBTCaccountbalance(_address);
    }

    try {
      final url = Uri.parse('https://api.coinbase.com/v2/prices/BTC-KES/spot');

      var response = await http.get(url);
      if (response.statusCode == 200) {
        var _fetchedmpesatransaction = json.decode(response.body) as dynamic;
        var _price = _fetchedmpesatransaction['data']['amount'];
        _btcPrice = _price;
        notifyListeners();
      } else {
        print(response.statusCode);
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> btchistoricalData(String interval) async {
    final url = Uri.parse(
        'https://api.exchange.coinbase.com/products/BTC-USD/candles/$interval');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var _historicaldata = json.decode(response.body) as dynamic;
      List<CandleData> _data = [];
      _historicaldata.forEach((data) {
        final _date = data[0].toString();
        final _high = data[2].toString();
        final _low = data[1].toString();
        final _open = data[3].toString();
        final _close = data[4].toString();
        final _volume = data[5].toString();
        _data.add(
          CandleData(
            high: double.parse(_high),
            low: double.parse(_low),
            open: double.parse(_open),
            close: double.parse(_close),
            volume: double.parse(_volume),
            timestamp: int.parse(_date),
          ),
        );
        // print(_data);
      });

      _candles = _data;
      notifyListeners();
    } else {
      print(response.statusCode);
    }
  }

  Future<void> createwallet(BuildContext context) async {
    try {
      final url = Uri.parse(
          'https://api.blockcypher.com/v1/bcy/test/addrs?token=384db6a387704d0c9534746d3ad52123');
      var response = await http.post(url);
      var _body = response.body;

      if (response.statusCode == 201) {
        var _data = json.decode(response.body) as dynamic;
        print('Create account date$_data');
        var _privatekey = _data['private'];
        var _publickey = _data['public'];
        var _address = _data['address'];
        var _wif = _data['_wif'];
        _prefs.write('wallet$_uid', true);
        await _prefs.write('_privatekey$_uid', _privatekey);
        await _prefs.write('_publickey$_uid', _publickey);
        await _prefs.write('_address$_uid', _address);
        await _prefs.write('_wif$_uid', _wif);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return HOMESCREEN();
            },
          ),
        );
      } else {}
    } catch (err) {
      print('Create account $err');
    }
  }

  Future<void> sendBTCTransactions(
      String amount, String forwardaddress, String myaddres) async {
    // var _private = _prefs.read('_privatekey$_uid');
    // var seed = bip39.mnemonicToSeedHex('basket actual');

  
    //var nodeFromseed = bip32.BIP32.fromSeed(seed ).chainCode;
   // var message = HEX.decode(
        //     "0202020202020202020202020202020202020202020202020202020202020202")
        // as Uint8List;
    // var signature = nodeFromseed.sign(message);

    // => [63, 219, 20, 114, 95, 184, 192, 55, 216, 206, 126, 121, 17, 71, 64, 70, 163, 82, 247, 73, 243, 95, 30, 137, 177, 155, 100, 225, 177, 203, 217, 147, 122, 64, 208, 129, 54, 133, 113, 41, 216, 160, 191, 15, 136, 98, 235, 25, 219, 178, 70, 222, 127, 151, 135, 242, 25, 192, 161, 187, 187, 84, 81, 215]

    // print(HEX.encode(signature));
    // => 3fdb14725fb8c037d8ce7e7911474046a352f749f35f1e89b19b64e1b1cbd9937a40d08136857129d8a0bf0f8862eb19dbb246de7f9787f219c0a1bbbb5451d7

    // print(nodeFromseed.verify(message, signature));

    try {
      final url = Uri.parse(
          'https://api.blockcypher.com/v1/bcy/test/txs/new?token=b479b9b826a446cebecdf6e163f5580');

      http.post(url,
          body: json.encode({
            "inputs": [
              {
                "addresses": [myaddres]
              }
            ],
            "outputs": [
              {
                "addresses": [forwardaddress],
                "value": 10000
              }
            ]
          }));
    } catch (err) {
      print('Create account $err');
    }
  }
}
