import 'package:bit254/Utilities/colors.dart';
import 'package:flutter/material.dart';

class SendCoins extends StatefulWidget {
  @override
  _SendCoinsState createState() => _SendCoinsState();
}

class _SendCoinsState extends State<SendCoins> {
  final TextEditingController _btcontroller = TextEditingController();

  @override
  void dispose() {
    _btcontroller.dispose();
    super.dispose();
  }

  final _bitcoinprice = 4000000;
  final _ethprice = 200000;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    @override
    List<Widget> tabs = [
      BitcoinSend(
        width: width,
        bitcoinprice: _bitcoinprice,
      ),
      EthSend(
        width: width,
        ethprice: _ethprice,
      ),
    ];

    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text('Send'),
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

class BitcoinSend extends StatefulWidget {
  const BitcoinSend({
    Key? key,
    required this.width,
    required int bitcoinprice,
  })  : _bitcoinprice = bitcoinprice,
        super(key: key);

  final double width;
  final int _bitcoinprice;

  @override
  _BitcoinSendState createState() => _BitcoinSendState();
}

class _BitcoinSendState extends State<BitcoinSend> {
  var _ksh;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              _ksh == null ? 'BTC 0.000' : 'BTC $_ksh',
            ),
            const SizedBox(height: 15),
            Container(
              width: widget.width,
              child: TextField(
                onChanged: (text) {},
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Bitcoin Address',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: widget.width,
              height: 40,
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: widget.width * .3,
                    alignment: Alignment.topRight,
                    child: TextField(
                      onChanged: (text) {
                        String ksh = text.isEmpty
                            ? '0.000'
                            : (int.parse(text) / widget._bitcoinprice)
                                .toString();
                        setState(() {
                          _ksh = ksh;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Amount in Ksh ',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.all(20),
                width: widget.width,
                child: ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                  child: Text(
                    'Scan Qr',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                )),
            Container(
                margin: EdgeInsets.all(20),
                width: widget.width,
                child: ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                  child: Text(
                    'Send',
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

class EthSend extends StatefulWidget {
  const EthSend({
    Key? key,
    required this.width,
    required int ethprice,
  })  : _ethprice = ethprice,
        super(key: key);

  final double width;
  final int _ethprice;

  @override
  _EthSendState createState() => _EthSendState();
}

class _EthSendState extends State<EthSend> {
  var _ksh;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              _ksh == null ? 'ETH 0.000' : 'ETH $_ksh',
            ),
            const SizedBox(height: 15),
            Container(
              width: widget.width,
              child: TextField(
                onChanged: (text) {},
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Etherium Address',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: widget.width,
              height: 40,
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: widget.width * .3,
                    alignment: Alignment.topRight,
                    child: TextField(
                      onChanged: (text) {
                        String ksh = text.isEmpty
                            ? '0.000'
                            : (int.parse(text) / widget._ethprice).toString();
                        setState(() {
                          _ksh = ksh;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Amount in Ksh ',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.all(20),
                width: widget.width,
                child: ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                  child: Text(
                    'Scan Qr',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                )),
            Container(
                margin: EdgeInsets.all(20),
                width: widget.width,
                child: ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                  child: Text(
                    'Send',
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
