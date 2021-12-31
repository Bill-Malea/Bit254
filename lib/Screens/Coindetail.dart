import 'package:bit254/Utilities/colors.dart';
import 'package:bit254/home/Dashboard/Transactions_List/BTC/provider_bitcointransactions.dart';
import 'package:bit254/home/Dashboard/Transactions_List/ETHERIUM/Etheriumtransactio_list.dart';
import 'package:bit254/model/coins.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CoinDetail extends StatelessWidget {
  final Coin coin;
  CoinDetail({required this.coin});
  Color getColor(Coin coin) {
    if (coin.type == CoinType.ETHEREUM) {
      return Colors.blue;
    }
    return Colors.orange;
  }

  getIcon(Coin coin) {
    if (coin.type == CoinType.ETHEREUM) {
      return CryptoFontIcons.ETH;
    }
    return CryptoFontIcons.BTC;
  }

  @override
  Widget build(BuildContext context) {
    getPrice(Coin coin) {
      final String _bitcoinprice =
          Provider.of<BTCProvider>(context).btcPrice.split('.')[0];
      final String _etheriumprice =
          Provider.of<ETHProvider>(context).ethPrice.split('.')[0];

      final String _btcprice =
          NumberFormat.currency(symbol: '', decimalDigits: 0)
              .format(int.parse(_bitcoinprice));
      final String _ethprice =
          NumberFormat.currency(symbol: '', decimalDigits: 0)
              .format(int.parse(_etheriumprice));

      if (coin.type == CoinType.ETHEREUM) {
        return _ethprice;
      }
      return _btcprice;
    }

    List<CandleData> _candlesBtc = Provider.of<BTCProvider>(context).btcCandles;
    List<CandleData> _candlesEth = Provider.of<ETHProvider>(context).ethCandles;
    return Scaffold(
      appBar: AppBar(
        elevation: 7,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            FlutterIcons.keyboard_backspace_mdi,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: EdgeInsets.only(
                    left: 12,
                    right: 15,
                    top: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${coin.getCoinAbbr()}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: getColor(coin),
                            borderRadius: BorderRadius.circular(5.0)),
                        height: 35,
                        width: 35,
                        child: Icon(
                          getIcon(coin),
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 400,
                child: _candlesEth.length < 4 && _candlesBtc.length < 4
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          color: kSuccessColor,
                        ),
                      )
                    : AspectRatio(
                        aspectRatio: 1.2,
                        child: InteractiveChart(
                          style: ChartStyle(
                            timeLabelStyle: TextStyle(
                              color: Colors.blue[200],
                              fontSize: 10,
                            ),
                            priceLabelStyle: TextStyle(
                              color: Colors.blue[200],
                              fontSize: 10,
                            ),
                            priceGridLineColor: Colors.transparent,
                            volumeColor: getColor(coin),
                          ),
                          timeLabel: (timestamp, visibleDataCount) => "",
                          priceLabel: (price) =>
                              "${price.round().truncate() / 10000} M ",
                          overlayInfo: (candle) => {},
                          candles: coin.type == CoinType.ETHEREUM
                              ? _candlesEth
                              : _candlesBtc,
                          // interval: '',
                        ),
                      ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 12,
                  right: 15,
                  top: 15,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PRICE",
                          style: TextStyle(
                            color: Colors.white24,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "MARKET CAP",
                          style: TextStyle(
                            color: Colors.white24,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Ksh  ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              getPrice(coin),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Ksh  ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              getPrice(coin),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
