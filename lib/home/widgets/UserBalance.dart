import 'package:bit254/Utilities/testdata.dart';
import 'package:bit254/home/widgets/coincard.dart';
import 'package:flutter/material.dart';

class UserBalance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Coins",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              Text(
                "Total amount Ksh 378,005",
                style: themeData.textTheme.caption,
              ),
            ],
          ),
          SizedBox(height: 14.0),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CoinCard(
                coin: StaticData.userCoins[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 16.0,
              );
            },
            itemCount: StaticData.userCoins.length,
          )
        ],
      ),
    );
  }
}
