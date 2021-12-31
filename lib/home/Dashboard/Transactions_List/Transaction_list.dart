import 'package:bit254/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'mpesa/MpesaTransactionList.dart';

class Transactionlist extends StatelessWidget {
  final String header;
  Transactionlist(this.header);

  @override
  Widget build(BuildContext context) {
    @override
    List<Widget> tabs = [
      MpesaTransactionList(),
      MpesaTransactionList(),
      MpesaTransactionList(),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Transactions'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              indicatorColor: kSuccessColor,
              indicatorWeight: 2.0,
              isScrollable: false,


              tabs: [
                Container(

                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Tab(
                    text: 'Mpesa',
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Tab(
                    text: 'BTC',
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Tab(
                    text: 'ETH',
                  ),
                ),
              ],
            )),
        body: TabBarView(children: [for (final tab in tabs) tab]),
      ),
    );
  }
}
