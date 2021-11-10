import 'dart:convert';

class PostModel {
  String post;
  String postId;
  String uid;
  int createdAt;

  PostModel({
    required this.post,
    required this.postId,
    required this.uid,
    required this.createdAt,
  });

  PostModel copyWith({
    String? post,
    String? postId,
    String? uid,
    int? createdAt,
  }) {
    return PostModel(
      post: post ?? this.post,
      postId: postId ?? this.postId,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'post': post,
      'postId': postId,
      'uid': uid,
      'createdAt': createdAt,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      post: map['post'],
      postId: map['postId'],
      uid: map['uid'],
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostModel(post: $post, postId: $postId, uid: $uid, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel &&
        other.post == post &&
        other.postId == postId &&
        other.uid == uid &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return post.hashCode ^ postId.hashCode ^ uid.hashCode ^ createdAt.hashCode;
  }
}
