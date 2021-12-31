import 'package:flutter/material.dart';

class Transactions with ChangeNotifier {
  final String privatekey = 'hfui7766766rwe44343ee34e4ee';
  void getBalance() {}
  void generateprivatekey() {}

  void initWallet() {}
}

class TransactionOut {
  final String address;
  final int amount;
  TransactionOut(this.address, this.amount);
}

class TransactionIn {
  final String txOutid;
  final int txOutIndex;
  final String signature;

  TransactionIn(this.txOutid, this.txOutIndex, this.signature);
}
