import 'package:bit254/Utilities/testdata.dart';
import 'package:bit254/home/Dashboard/FundWallet/components/FundWallet.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'Receive.dart';
import 'SendCoins.dart';
import 'Transactions_List/Transaction_list.dart';
import 'package:bit254/Utilities/adaptive_size.dart';
import 'navbutton.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 250.0.h,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        children: <Widget>[
          Navbutton(
            'Fund Wallet',
            Icons.account_balance_wallet,
            FundWallet(
              'Buy Crypto',
            ),
            false,
          ),
          Navbutton(
            'Transactions',
            Icons.receipt,
            Transactionlist('Transactions'),
            false,
          ),
          Navbutton(
            'Sell',
            Icons.payment,
            FundWallet(
              'Sell',
            ),
            false,
          ),
          Navbutton(
            'Receive',
            Icons.south_east_rounded,
            ReceiveCoins(),
            false,
          ),
          Navbutton(
            'Send',
            Icons.north_east,
            SendCoins(),
            false,
          ),
          Navbutton(
            'Pay Bills',
            Icons.payment,
            FundWallet(
              'Pay Bills',
            ),
            true,
          ),
        ],
      ),
    );
  }
}

class FundWallet extends StatelessWidget {
  final String header;
  FundWallet(this.header);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            FlutterIcons.keyboard_backspace_mdi,
          ),
        ),
        centerTitle: true,
        title: Text(
          header,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            CoinCard(
              coin: StaticData.userCoins[0],
            ),
            SizedBox(
              height: 15,
            ),
            CoinCard(
              coin: StaticData.userCoins[1],
            )
          ],
        ),
      ),
    );
  }
}
