import 'dart:convert';

class NewsModel {
  String category;
  int datetime;
  int id;
  String headline;
  String image;
  String related;
  String source;
  String summary;
  String url;

  NewsModel({
    required this.category,
    required this.datetime,
    required this.id,
    required this.headline,
    required this.image,
    required this.related,
    required this.source,
    required this.summary,
    required this.url,
  });

  NewsModel copyWith({
    String? category,
    int? datetime,
    int? id,
    String? headline,
    String? image,
    String? related,
    String? source,
    String? summary,
    String? url,
  }) {
    return NewsModel(
      category: category ?? this.category,
      datetime: datetime ?? this.datetime,
      id: id ?? this.id,
      headline: headline ?? this.headline,
      image: image ?? this.image,
      related: related ?? this.related,
      source: source ?? this.source,
      summary: summary ?? this.summary,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'datetime': datetime,
      'id': id,
      'headline': headline,
      'image': image,
      'related': related,
      'source': source,
      'summary': summary,
      'url': url,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      category: map['category'],
      datetime: map['datetime'],
      id: map['id'],
      headline: map['headline'],
      image: map['image'],
      related: map['related'],
      source: map['source'],
      summary: map['summary'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewsModel(category: $category, datetime: $datetime, id: $id, headline: $headline, image: $image, related: $related, source: $source, summary: $summary, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsModel &&
        other.category == category &&
        other.datetime == datetime &&
        other.id == id &&
        other.headline == headline &&
        other.image == image &&
        other.related == related &&
        other.source == source &&
        other.summary == summary &&
        other.url == url;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        datetime.hashCode ^
        id.hashCode ^
        headline.hashCode ^
        image.hashCode ^
        related.hashCode ^
        source.hashCode ^
        summary.hashCode ^
        url.hashCode;
  }
}
