import 'dart:convert';

class UsMarketModel {
  num c;
  num d;
  num dp;
  num h;
  num l;
  num o;
  num pc;

  UsMarketModel({
    required this.c,
    required this.d,
    required this.dp,
    required this.h,
    required this.l,
    required this.o,
    required this.pc,
  });

  UsMarketModel copyWith({
    num? c,
    num? d,
    num? dp,
    num? h,
    num? l,
    num? o,
    num? pc,
  }) {
    return UsMarketModel(
      c: c ?? this.c,
      d: d ?? this.d,
      dp: dp ?? this.dp,
      h: h ?? this.h,
      l: l ?? this.l,
      o: o ?? this.o,
      pc: pc ?? this.pc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'c': c,
      'd': d,
      'dp': dp,
      'h': h,
      'l': l,
      'o': o,
      'pc': pc,
    };
  }

  factory UsMarketModel.fromMap(Map<String, dynamic> map) {
    return UsMarketModel(
      c: map['c'],
      d: map['d'],
      dp: map['dp'],
      h: map['h'],
      l: map['l'],
      o: map['o'],
      pc: map['pc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsMarketModel.fromJson(String source) =>
      UsMarketModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UsMarketModel(c: $c, d: $d, dp: $dp, h: $h, l: $l, o: $o, pc: $pc)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsMarketModel &&
        other.c == c &&
        other.d == d &&
        other.dp == dp &&
        other.h == h &&
        other.l == l &&
        other.o == o &&
        other.pc == pc;
  }

  @override
  int get hashCode {
    return c.hashCode ^
        d.hashCode ^
        dp.hashCode ^
        h.hashCode ^
        l.hashCode ^
        o.hashCode ^
        pc.hashCode;
  }
}
