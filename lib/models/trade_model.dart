import 'dart:convert';

class TradeModel {
  String baseMarket;
  String quoteMarket;
  String trade;
  String transactionId;
  String uid;
  int at;
  num buy;
  num sell;
  num high;
  num low;
  num volume;
  num coins;
  num amount;

  TradeModel({
    required this.baseMarket,
    required this.quoteMarket,
    required this.trade,
    required this.transactionId,
    required this.uid,
    required this.at,
    required this.buy,
    required this.sell,
    required this.high,
    required this.low,
    required this.volume,
    required this.coins,
    required this.amount,
  });

  TradeModel copyWith({
    String? baseMarket,
    String? quoteMarket,
    String? trade,
    String? transactionId,
    String? uid,
    int? at,
    num? buy,
    num? sell,
    num? high,
    num? low,
    num? volume,
    num? coins,
    num? amount,
  }) {
    return TradeModel(
      baseMarket: baseMarket ?? this.baseMarket,
      quoteMarket: quoteMarket ?? this.quoteMarket,
      trade: trade ?? this.trade,
      transactionId: transactionId ?? this.transactionId,
      uid: uid ?? this.uid,
      at: at ?? this.at,
      buy: buy ?? this.buy,
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
      'transactionId': transactionId,
      'uid': uid,
      'at': at,
      'buy': buy,
      'sell': sell,
      'high': high,
      'low': low,
      'volume': volume,
      'coins': coins,
      'amount': amount,
    };
  }

  factory TradeModel.fromMap(Map<String, dynamic> map) {
    return TradeModel(
      baseMarket: map['baseMarket'],
      quoteMarket: map['quoteMarket'],
      trade: map['trade'],
      transactionId: map['transactionId'],
      uid: map['uid'],
      at: map['at'],
      buy: map['buy'],
      sell: map['sell'],
      high: map['high'],
      low: map['low'],
      volume: map['volume'],
      coins: map['coins'],
      amount: map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TradeModel.fromJson(String source) =>
      TradeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TradeModel(baseMarket: $baseMarket, quoteMarket: $quoteMarket, trade: $trade, transactionId: $transactionId, uid: $uid, at: $at, buy: $buy, sell: $sell, high: $high, low: $low, volume: $volume, coins: $coins, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TradeModel &&
        other.baseMarket == baseMarket &&
        other.quoteMarket == quoteMarket &&
        other.trade == trade &&
        other.transactionId == transactionId &&
        other.uid == uid &&
        other.at == at &&
        other.buy == buy &&
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
        transactionId.hashCode ^
        uid.hashCode ^
        at.hashCode ^
        buy.hashCode ^
        sell.hashCode ^
        high.hashCode ^
        low.hashCode ^
        volume.hashCode ^
        coins.hashCode ^
        amount.hashCode;
  }
}
