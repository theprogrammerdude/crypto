import 'dart:convert';

import 'package:flutter/foundation.dart';

class DepthModel {
  List asks;
  List bids;

  DepthModel({
    required this.asks,
    required this.bids,
  });

  DepthModel copyWith({
    List? asks,
    List? bids,
  }) {
    return DepthModel(
      asks: asks ?? this.asks,
      bids: bids ?? this.bids,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'asks': asks,
      'bids': bids,
    };
  }

  factory DepthModel.fromMap(Map<String, dynamic> map) {
    return DepthModel(
      asks: List.from(map['asks']),
      bids: List.from(map['bids']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DepthModel.fromJson(String source) =>
      DepthModel.fromMap(json.decode(source));

  @override
  String toString() => 'DepthModel(asks: $asks, bids: $bids)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DepthModel &&
        listEquals(other.asks, asks) &&
        listEquals(other.bids, bids);
  }

  @override
  int get hashCode => asks.hashCode ^ bids.hashCode;
}
