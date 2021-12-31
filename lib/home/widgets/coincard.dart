import 'package:bit254/Screens/Coindetail.dart';
import 'package:bit254/Utilities/colors.dart';
import 'package:bit254/model/coins.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:bit254/Utilities/adaptive_size.dart';

class CoinCard extends StatelessWidget {
  final Coin coin;
  CoinCard({required this.coin});
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return CoinDetail(coin: this.coin);
            },
          ),
        );
      },
      child: Container(
        height: 70.0.h,
        // color: Color.fromRGBO(55, 66, 92, 0.4),
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Row(
          children: [
            Container(
                width: 40.0.w,
                child: coin.type == CoinType.BITCOIN
                    ? Icon(
                        CryptoFontIcons.BTC,
                        color: Colors.orange,
                        size: 28,
                      )
                    : Icon(
                        CryptoFontIcons.ETH,
                        color: Colors.white,
                        size: 28,
                      )),
           
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${coin.toString()} (${coin.getCoinAbbr()})",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "${coin.balance}",
                  style: themeData.textTheme.caption!.copyWith(fontSize: 14.0),
                ),
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${coin.currentPrice}",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Text(
                      getCoinProgress(coin),
                      style: TextStyle(
                        color: coin.trend == Trend.UP
                            ? kSuccessColor
                            : kDangerColor,
                        fontSize: 13.0,
                      ),
                    ),
                    Icon(
                      coin.trend == Trend.UP
                          ? FlutterIcons.caret_up_faw
                          : FlutterIcons.caret_down_faw,
                      size: 14.0,
                      color:
                          coin.trend == Trend.UP ? kSuccessColor : kDangerColor,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

String getCoinProgress(Coin coin) {
  String returnValue = "";

  if (coin.trend == Trend.UP) {
    returnValue += "+";
  } else {
    returnValue += "-";
  }

  returnValue += "\$${coin.amountProgress} (${coin.percentProgress}%)";

  return returnValue;
}
