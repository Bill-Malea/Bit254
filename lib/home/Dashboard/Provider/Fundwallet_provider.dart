import 'package:flutter/material.dart';
import 'package:mpesa/mpesa.dart';

class FundwalletProvider with ChangeNotifier {

  final mpesa = Mpesa(
    environment: 'sandbox',
    passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
    clientKey: "OBjOaunSAchhYKM6mB7helT36Slg1grw",
    clientSecret: "WCcbntBI1Di9txIa",
  );
}
