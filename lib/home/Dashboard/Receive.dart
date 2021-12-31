import 'package:bit254/Utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'Transactions_List/BTC/provider_bitcointransactions.dart';
import 'Transactions_List/ETHERIUM/Etheriumtransactio_list.dart';

class ReceiveCoins extends StatefulWidget {
  @override
  _ReceiveCoinsState createState() => _ReceiveCoinsState();
}

class _ReceiveCoinsState extends State<ReceiveCoins> {
  final TextEditingController _btcontroller = TextEditingController();
  final _uid = FirebaseAuth.instance.currentUser!.uid;
  final _prefs = GetStorage();
  @override
  void dispose() {
    _btcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String _bitcoinaddress = _prefs.read(
      '_address$_uid',
    );

    final String _ethaddress = 'Cj75ggD644fcFF7H6BgV77dft6ygfr67h';
    var _bitcoinprice = Provider.of<BTCProvider>(
      context,
    ).btcPrice;
    final _ethprice = Provider.of<ETHProvider>(
      context,
    ).ethPrice;

    final width = MediaQuery.of(context).size.width;

    @override
    List<Widget> tabs = [
      Bitcoinreceive(
        bitcoinaddress: _bitcoinaddress,
        width: width,
        bitcoinprice: _bitcoinprice,
      ),
      Ethreceive(
        width: width,
        ethaddress: _ethaddress,
        ethprice: _ethprice,
      ),
    ];

    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text('Receive'),
              centerTitle: true,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                indicatorColor: kSuccessColor,
                indicatorWeight: 2.0,
                isScrollable: false,
                tabs: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Tab(
                      text: 'BTC',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Tab(
                      text: 'ETH',
                    ),
                  ),
                ],
              )),
          body: TabBarView(children: [for (final tab in tabs) tab]),
        ));
  }
}

class Bitcoinreceive extends StatefulWidget {
  const Bitcoinreceive({
    Key? key,
    required String bitcoinaddress,
    required this.width,
    required String bitcoinprice,
  })  : _bitcoinaddress = bitcoinaddress,
        _bitcoinprice = bitcoinprice,
        super(key: key);

  final String _bitcoinaddress;
  final double width;
  final String _bitcoinprice;

  @override
  _BitcoinreceiveState createState() => _BitcoinreceiveState();
}

class _BitcoinreceiveState extends State<Bitcoinreceive> {
  var _btc;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          children: [
            Text('My Bitcoin Address Scan Qr To receive Coins '),
            Container(
              child: QrImage(
                version: QrVersions.auto,
                data: widget._bitcoinaddress,
              ),
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget._bitcoinaddress),
                  Row(
                    children: [
                      Icon(
                        Icons.copy,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                      SizedBox(
                        height: 15,
                        child: Text(
                          'Copy',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: widget.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('BTC'),
                  Text('KSH'),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: widget.width,
              height: 20,
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: widget.width * .3,
                    alignment: Alignment.topLeft,
                    child: Text(
                      _btc == null ? '0.000' : _btc,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Container(
                    width: widget.width * .3,
                    alignment: Alignment.topRight,
                    child: TextField(
                      onChanged: (text) {
                        String btc = text.isEmpty
                            ? '0.000'
                            : ((int.parse(text)) /
                                    (double.parse(widget._bitcoinprice)))
                                .toString();

                        setState(() {
                          _btc = btc;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '0.000',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                  ), //ButtonStyle(backgroundColor: ),
                  child: Text(
                    'Share Address',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class Ethreceive extends StatefulWidget {
  const Ethreceive({
    Key? key,
    required String ethaddress,
    required this.width,
    required String ethprice,
  })  : _ethaddress = ethaddress,
        super(key: key);

  final String _ethaddress;
  final double width;

  @override
  _EthreceiveState createState() => _EthreceiveState();
}

class _EthreceiveState extends State<Ethreceive> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'My Etherium Address Scan Qr To receive Coins',
            ),
            Container(
              child: QrImage(
                version: QrVersions.auto,
                data: widget._ethaddress,
              ),
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget._ethaddress),
                  Row(
                    children: [
                      Icon(
                        Icons.copy,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                      SizedBox(
                        height: 15,
                        child: Text(
                          'Copy',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                  child: Text(
                    'Share Address',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
