import 'package:bit254/Utilities/stringextension.dart';

enum CoinType {
  
  BITCOIN,
  ETHEREUM,
  LITECOIN,
  MONERO,
  TRON,
}

enum Trend { UP, DOWN }

class Coin {
  final CoinType? type;
  final double? currentPrice;
  final double? percentProgress;
  final double? amountProgress;
  final double? balance;
  final Trend? trend;

  Coin({
    this.currentPrice,
    this.percentProgress,
    this.amountProgress,
    this.balance,
    this.type,
    this.trend,
  });

  String getCoinAbbr() {
    if (this.type == CoinType.BITCOIN) {
      return "BTC";
    } else
      return "ETH";
  }

  String getImagePath() {
    if (this.type == CoinType.BITCOIN) {
      return "assets/images/bitcoin.png";
    } else
      return "assets/images/ethereum.png";
  }

  @override
  String toString() {
    String firstPart = this.type.toString().split(".")[1];
    return firstPart.capitalize();
  }
}
