import 'package:bit254/model/coins.dart';

class StaticData {
  static final List<Coin> userCoins = [
    Coin(
      amountProgress: 82.13,
      balance: 0.00692133,
      currentPrice: 3432.92,
      type: CoinType.BITCOIN,
      percentProgress: 3,
      trend: Trend.UP,
    ),
    Coin(
      amountProgress: 13.10,
      balance: 2.45670,
      currentPrice: 90.96,
      type: CoinType.ETHEREUM,
      percentProgress: 2.3,
      trend: Trend.UP,
    ),
  ];
}
