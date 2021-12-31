import 'package:bit254/Utilities/colors.dart';
import 'package:bit254/model/coins.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:bit254/Utilities/adaptive_size.dart';
import 'components/paymentcard.dart';

class CoinCard extends StatefulWidget {
  final Coin coin;
  CoinCard({required this.coin});

  @override
  _CoinCardState createState() => _CoinCardState();
}

class _CoinCardState extends State<CoinCard> {
  @override
  Widget build(BuildContext context) {
   
    void _bottomsheetPayment(
        context, String _header, bool _ismpesa, bool _stkpush) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              color: kPrimaryColor,
              child: Container(
                height: _ismpesa ? 650 : 350,
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$_header Payment ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _ismpesa
                      ? widget.coin.type == CoinType.BITCOIN
                          ? PaymentCard(
                              phonenumber: '0727800223',
                              isbitcoin: true,
                              width: MediaQuery.of(context).size.width,
                              bitcoinprice: 45000000,
                            )
                          : PaymentCard(
                              isbitcoin: false,
                              width: MediaQuery.of(context).size.width,
                              bitcoinprice: 45000000,
                              phonenumber: '0727800223',
                            )
                      : _stkpush
                          ? Container()
                          : Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(
                                left: 30,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Go To Mpesa '),
                                  Text('Select PayBill'),
                                  Text('Enter Account Number: 0727800223'),
                                  Text('Enter Business Number: 776285'),
                                  Text('Enter Amount'),
                                  Text('Enter Pin'),
                                ],
                              ),
                            ),
                ]),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        15,
                      ),
                      topRight: Radius.circular(
                        15,
                      ),
                    )),
              ),
            );
          });
    }

    void _bottomsheetPaymentmethod(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              color: kPrimaryColor,
              child: Container(
                height: 300,
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Payment Method',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      _bottomsheetPayment(context, 'Mpesa', true, true);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white12,
                        child: Image.asset('assets/images/mpesa.png'),
                      ),
                      title: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text('Mpesa')),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      _bottomsheetPayment(context, 'Equity Bank ', false, true);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.asset('assets/images/equity.png'),
                      ),
                      title: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text('Eazzy Pay ')),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      _bottomsheetPayment(context, 'Equitel', false, false);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.asset('assets/images/equity.png'),
                      ),
                      title: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text('Equitel')),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        _bottomsheetPayment(context, 'DTB BANK', false, false);
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Container(
                            child: Image.asset('assets/images/dtb.jpg'),
                          ),
                        ),
                        title: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text('DTB Bank')),
                      )),
                ]),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        15,
                      ),
                      topRight: Radius.circular(
                        15,
                      ),
                    )),
              ),
            );
          });
    }

    return GestureDetector(
      onTap: () {
        _bottomsheetPaymentmethod(context);
      },
      child: Container(
        height: 40.0.h,
        color: Colors.transparent, //Color.fromRGBO(55, 66, 92, 0.4),
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Row(
          children: [
            Container(
                child: widget.coin.type == CoinType.BITCOIN
                    ? Icon(
                        CryptoFontIcons.BTC,
                        color: Colors.orange,
                        size: 28,
                      )
                    : Icon(
                        CryptoFontIcons.ETH,
                        color: Colors.white,
                        size: 29,
                      )),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.coin.toString()}",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
