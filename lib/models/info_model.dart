import 'dart:convert';

class InfoModel {
  int id;
  String name;
  String symbol;
  String category;
  String description;
  String logo;

  InfoModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.category,
    required this.description,
    required this.logo,
  });

  InfoModel copyWith({
    int? id,
    String? name,
    String? symbol,
    String? category,
    String? description,
    String? logo,
  }) {
    return InfoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      category: category ?? this.category,
      description: description ?? this.description,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'category': category,
      'description': description,
      'logo': logo,
    };
  }

  factory InfoModel.fromMap(Map<String, dynamic> map) {
    return InfoModel(
      id: map['id'],
      name: map['name'],
      symbol: map['symbol'],
      category: map['category'],
      description: map['description'],
      logo: map['logo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InfoModel.fromJson(String source) =>
      InfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InfoModel(id: $id, name: $name, symbol: $symbol, category: $category, description: $description, logo: $logo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InfoModel &&
        other.id == id &&
        other.name == name &&
        other.symbol == symbol &&
        other.category == category &&
        other.description == description &&
        other.logo == logo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        symbol.hashCode ^
        category.hashCode ^
        description.hashCode ^
        logo.hashCode;
  }
}
