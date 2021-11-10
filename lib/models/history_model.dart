import 'dart:convert';

class HistoryModel {
  String baseMarket;
  String quoteMarket;
  String trade;
  String uid;
  int at;
  num buy;
  num prevBuy;
  num prevSell;
  num sell;
  num high;
  num low;
  num volume;
  num coins;
  num amount;

  HistoryModel({
    required this.baseMarket,
    required this.quoteMarket,
    required this.trade,
    required this.uid,
    required this.at,
    required this.buy,
    required this.prevBuy,
    required this.prevSell,
    required this.sell,
    required this.high,
    required this.low,
    required this.volume,
    required this.coins,
    required this.amount,
  });

  HistoryModel copyWith({
    String? baseMarket,
    String? quoteMarket,
    String? trade,
    String? uid,
    int? at,
    num? buy,
    num? prevBuy,
    num? prevSell,
    num? sell,
    num? high,
    num? low,
    num? volume,
    num? coins,
    num? amount,
  }) {
    return HistoryModel(
      baseMarket: baseMarket ?? this.baseMarket,
      quoteMarket: quoteMarket ?? this.quoteMarket,
      trade: trade ?? this.trade,
      uid: uid ?? this.uid,
      at: at ?? this.at,
      buy: buy ?? this.buy,
      prevBuy: prevBuy ?? this.prevBuy,
      prevSell: prevSell ?? this.prevSell,
      sell: sell ?? this.sell,
      high: high ?? this.high,
      low: low ?? this.low,
      volume: volume ?? this.volume,
      coins: coins ?? this.coins,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'baseMarket': baseMarket,
      'quoteMarket': quoteMarket,
      'trade': trade,
      'uid': uid,
      'at': at,
      'buy': buy,
      'prevBuy': prevBuy,
      'prevSell': prevSell,
      'sell': sell,
      'high': high,
      'low': low,
      'volume': volume,
      'coins': coins,
      'amount': amount,
    };
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      baseMarket: map['baseMarket'],
      quoteMarket: map['quoteMarket'],
      trade: map['trade'],
      uid: map['uid'],
      at: map['at'],
      buy: map['buy'],
      prevBuy: map['prevBuy'],
      prevSell: map['prevSell'],
      sell: map['sell'],
      high: map['high'],
      low: map['low'],
      volume: map['volume'],
      coins: map['coins'],
      amount: map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryModel.fromJson(String source) =>
      HistoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HistoryModel(baseMarket: $baseMarket, quoteMarket: $quoteMarket, trade: $trade, uid: $uid, at: $at, buy: $buy, prevBuy: $prevBuy, prevSell: $prevSell, sell: $sell, high: $high, low: $low, volume: $volume, coins: $coins, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryModel &&
        other.baseMarket == baseMarket &&
        other.quoteMarket == quoteMarket &&
        other.trade == trade &&
        other.uid == uid &&
        other.at == at &&
        other.buy == buy &&
        other.prevBuy == prevBuy &&
        other.prevSell == prevSell &&
        other.sell == sell &&
        other.high == high &&
        other.low == low &&
        other.volume == volume &&
        other.coins == coins &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return baseMarket.hashCode ^
        quoteMarket.hashCode ^
        trade.hashCode ^
        uid.hashCode ^
        at.hashCode ^
        buy.hashCode ^
        prevBuy.hashCode ^
        prevSell.hashCode ^
        sell.hashCode ^
        high.hashCode ^
        low.hashCode ^
        volume.hashCode ^
        coins.hashCode ^
        amount.hashCode;
  }
}
