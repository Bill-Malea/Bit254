import 'package:bit254/Utilities/colors.dart';
import 'package:bit254/home/Dashboard/Transactions_List/mpesa/provider_mpesatransactionlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentCard extends StatefulWidget {
  const PaymentCard({
    Key? key,
    required this.width,
    required this.phonenumber,
    required int bitcoinprice,
    required this.isbitcoin,
  })  : _bitcoinprice = bitcoinprice,
        super(key: key);

  final double width;
  final int _bitcoinprice;
  final bool isbitcoin;
  final String phonenumber;

  @override
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  var _coins;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              widget.isbitcoin
                  ? Text(
                      _coins == null ? 'BTC 0.000' : 'BTC $_coins',
                    )
                  : Text(
                      _coins == null ? 'ETH 0.000' : 'ETH $_coins',
                    ),
              const SizedBox(height: 5),
              Container(
                alignment: Alignment.bottomCenter,
                width: widget.width * .3,
                child: TextFormField(
                  initialValue: widget.phonenumber,
                  onChanged: (text) {},
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Mpesa Number',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ),
              Container(
                width: widget.width * .3,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: widget.width * .3,
                      alignment: Alignment.bottomCenter,
                      child: TextField(
                        onChanged: (text) {
                          String coin = text.isEmpty
                              ? '0.000'
                              : (int.parse(text) / widget._bitcoinprice)
                                  .toStringAsFixed(7)
                                  .toString();
                          setState(() {
                            _coins = coin;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Amount ',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        onPressed: () {
                          Provider.of<Mpesatransactionlist>(context,
                                  listen: false)
                              .initiatepayment();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                        ),
                        child: Text(
                          'Make Payment',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        clipBehavior: Clip.antiAlias,
                        onPressed: Navigator.of(context).pop,
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
