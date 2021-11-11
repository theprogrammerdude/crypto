import 'dart:convert';

class CommentModel {
  String comment;
  String commentId;
  String uid;
  int at;

  CommentModel({
    required this.comment,
    required this.commentId,
    required this.uid,
    required this.at,
  });

  CommentModel copyWith({
    String? comment,
    String? commentId,
    String? uid,
    int? at,
  }) {
    return CommentModel(
      comment: comment ?? this.comment,
      commentId: commentId ?? this.commentId,
      uid: uid ?? this.uid,
      at: at ?? this.at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'commentId': commentId,
      'uid': uid,
      'at': at,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      comment: map['comment'],
      commentId: map['commentId'],
      uid: map['uid'],
      at: map['at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommentModel(comment: $comment, commentId: $commentId, uid: $uid, at: $at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentModel &&
        other.comment == comment &&
        other.commentId == commentId &&
        other.uid == uid &&
        other.at == at;
  }

  @override
  int get hashCode {
    return comment.hashCode ^ commentId.hashCode ^ uid.hashCode ^ at.hashCode;
  }
}
