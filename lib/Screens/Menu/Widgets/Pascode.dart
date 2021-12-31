import 'package:bit254/Providers/Auth.dart';
import 'package:bit254/home/Dashboard/Transactions_List/BTC/provider_bitcointransactions.dart';
import 'package:bit254/home/Dashboard/Transactions_List/ETHERIUM/Etheriumtransactio_list.dart';
import 'package:bit254/home/Dashboard/Transactions_List/mpesa/provider_mpesatransactionlist.dart';
import 'package:bit254/home/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bit254/Utilities/adaptive_size.dart';
import 'package:bit254/Utilities/colors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class Passcode extends StatefulWidget {
  @override
  _PasscodeState createState() => _PasscodeState();
}

class _PasscodeState extends State<Passcode> {
  void didChangeDependencies() {
    Provider.of<BTCProvider>(context, listen: false).btchistoricalData('300');
    Provider.of<ETHProvider>(context, listen: false).ethhistoricalData('300');
    Provider.of<ETHProvider>(context, listen: false).getETHprice();
    Provider.of<BTCProvider>(context, listen: false).getBTCprice();
    Provider.of<Mpesatransactionlist>(context, listen: false)
        .getmpesatransactions();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => auth(
          context: context,
        ));

    super.initState();
  }

  var selectedindex = 0;

  String code = '';
  String pin = '1305';

  _showdialog(bool correctpin) {
    correctpin
        ? showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              Future.delayed(Duration(seconds: 5), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return HOMESCREEN();
                    },
                  ),
                );
              });
              return AlertDialog(
                actions: <Widget>[
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
                          strokeWidth: 2.0,
                          color: kSuccessColor,
                        ),
                        SizedBox(width: 15),
                        Text('Decrypting Wallet...'),
                      ],
                    ),
                  ),
                ],
              );
            })
        : showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              content: Text('Wrong Pin'),
              actions: [
                Column(
                  children: <Widget>[
                    TextButton(
                      child: Text(
                        'Retry',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        setState(() {
                          code = '';
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          );

    return;
  }

  @override
  Widget build(BuildContext context) {
    GetStorage _pref = GetStorage();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final _biometric = _pref.read('_biometrics$uid');
    final did = didauth;

    TextStyle textStyle = TextStyle(
      fontSize: 18,
      color: kSuccessColor,
    );

    var width = MediaQuery.of(context).size.width;

    Color getColor() {
      if (did == true) {
        return Colors.green;
      } else if (did == false) {
        return Colors.red;
        // ignore: unnecessary_null_comparison
      }
      return Colors.white;
    }

    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          children: [
            SizedBox(
              height: 300.0.h,
            ),
            _biometric == true
                ? Container(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      child: Icon(
                        Icons.fingerprint,
                        size: 50,
                        color: getColor(),
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Enter PIN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Container(
                height: 50,
                margin: EdgeInsets.all(7),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DigitHolder(
                      width: width,
                      index: 0,
                      selectedIndex: selectedindex,
                      code: code,
                    ),
                    DigitHolder(
                        width: width,
                        index: 1,
                        selectedIndex: selectedindex,
                        code: code),
                    DigitHolder(
                        width: width,
                        index: 2,
                        selectedIndex: selectedindex,
                        code: code),
                    DigitHolder(
                        width: width,
                        index: 3,
                        selectedIndex: selectedindex,
                        code: code),
                  ],
                )),
            Expanded(
              flex: 3,
              child: Container(
                color: kPrimaryColor,
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: 80.0.h,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(1);
                                    },
                                    child: Text('1', style: textStyle)),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(2);
                                    },
                                    child: Text('2', style: textStyle)),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(3);
                                    },
                                    child: Text('3', style: textStyle)),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(4);
                                    },
                                    child: Text('4', style: textStyle)),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(5);
                                    },
                                    child: Text('5', style: textStyle)),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(6);
                                    },
                                    child: Text('6', style: textStyle)),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(7);
                                    },
                                    child: Text('7', style: textStyle)),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(8);
                                    },
                                    child: Text('8', style: textStyle)),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(9);
                                    },
                                    child: Text('9', style: textStyle)),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(0);
                                    },
                                    child: Text('0', style: textStyle)),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      backspace();
                                    },
                                    child: Icon(
                                      Icons.backspace_rounded,
                                      color: kSuccessColor,
                                      size: 20,
                                    )),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  addDigit(int digit) {
    if (code.length > 3) {
      return;
    }
    setState(() {
      code = code + digit.toString();
      print('Code is $code');
      selectedindex = code.length;

      if (code == pin) {
        _showdialog(true);
      } else if (code != pin && code.length == 4) {
        _showdialog(false);
      }
    });
  }

  backspace() {
    if (code.length == 0) {
      return;
    }
    setState(() {
      code = code.substring(0, code.length - 1);
      selectedindex = code.length;
    });
  }
}

class DigitHolder extends StatelessWidget {
  final int selectedIndex;
  final int index;
  final String code;
  const DigitHolder({
    required this.selectedIndex,
    Key? key,
    required this.width,
    required this.index,
    required this.code,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: width * 0.12,
      width: width * 0.12,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Color.fromRGBO(55, 66, 92, 0.4),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: index > 0 && index == selectedIndex
                  ? kSuccessColor
                  : Colors.transparent,
              offset: Offset(0, 0),
              spreadRadius: 1.5,
              blurRadius: 2,
            )
          ]),
      child: code.length > index
          ? Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: kSuccessColor,
                shape: BoxShape.circle,
              ),
            )
          : Container(),
    );
  }
}

class Authicon extends StatelessWidget {
  final Color color;

  const Authicon({required this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.fingerprint,
      size: 60,
      color: color,
    );
  }
}
