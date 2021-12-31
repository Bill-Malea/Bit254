import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:interactive_chart/interactive_chart.dart';
import 'package:intl/intl.dart';

class ETHProvider with ChangeNotifier {
   final _prefs = GetStorage();
  final _uid = FirebaseAuth.instance.currentUser!.uid;
  String _ethPrice = '';
  String get ethPrice {
      var _format =
        NumberFormat.currency(locale: "en US", symbol: "", decimalDigits: 0);
    var _addressbalance = _prefs.read(
      '_etherwalletbalance$_uid',
    );

    var _amount = _format.format(
        ((_addressbalance == null ? 0 :_addressbalance) * (_ethPrice.isEmpty ? 0 : double.tryParse(_ethPrice))));
    return _amount;
  }
  List<CandleData> _candles = [];

  List<CandleData> get ethCandles {
    return [..._candles];
  }

  Future<void> getETHtransactions() async {}
  Future<void> getETHprice() async {
    final url =  Uri.parse('https://api.coinbase.com/v2/prices/ETH-KES/spot');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var _fetchedata = json.decode(response.body) as dynamic;
      var _price = _fetchedata['data']['amount'];

      _ethPrice = _price;
      notifyListeners();
    }
  }




   Future<void> ethhistoricalData(String interval) async {
    final url = Uri.parse(
        'https://api.exchange.coinbase.com/products/ETH-USD/candles/$interval');
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
            timestamp: int.parse(_date),
            high: double.parse(_high),
            low: double.parse(_low),
            open: double.parse(_open),
            close: double.parse(_close),
            volume: double.parse(_volume),
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
}
