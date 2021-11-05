import 'dart:convert';

class MarketModel {
  String baseMarket;
  String quoteMarket;
  String low;
  String high;
  String volume;
  String sell;
  String buy;
  int at;
  MarketModel({
    required this.baseMarket,
    required this.quoteMarket,
    required this.low,
    required this.high,
    required this.volume,
    required this.sell,
    required this.buy,
    required this.at,
  });

  MarketModel copyWith({
    String? baseMarket,
    String? quoteMarket,
    String? low,
    String? high,
    String? volume,
    String? sell,
    String? buy,
    int? at,
  }) {
    return MarketModel(
      baseMarket: baseMarket ?? this.baseMarket,
      quoteMarket: quoteMarket ?? this.quoteMarket,
      low: low ?? this.low,
      high: high ?? this.high,
      volume: volume ?? this.volume,
      sell: sell ?? this.sell,
      buy: buy ?? this.buy,
      at: at ?? this.at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'baseMarket': baseMarket,
      'quoteMarket': quoteMarket,
      'low': low,
      'high': high,
      'volume': volume,
      'sell': sell,
      'buy': buy,
      'at': at,
    };
  }

  factory MarketModel.fromMap(Map<String, dynamic> map) {
    return MarketModel(
      baseMarket: map['baseMarket'],
      quoteMarket: map['quoteMarket'],
      low: map['low'],
      high: map['high'],
      volume: map['volume'],
      sell: map['sell'],
      buy: map['buy'],
      at: map['at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MarketModel.fromJson(String source) =>
      MarketModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MarketModel(baseMarket: $baseMarket, quoteMarket: $quoteMarket, low: $low, high: $high, volume: $volume, sell: $sell, buy: $buy, at: $at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MarketModel &&
        other.baseMarket == baseMarket &&
        other.quoteMarket == quoteMarket &&
        other.low == low &&
        other.high == high &&
        other.volume == volume &&
        other.sell == sell &&
        other.buy == buy &&
        other.at == at;
  }

  @override
  int get hashCode {
    return baseMarket.hashCode ^
        quoteMarket.hashCode ^
        low.hashCode ^
        high.hashCode ^
        volume.hashCode ^
        sell.hashCode ^
        buy.hashCode ^
        at.hashCode;
  }
}
