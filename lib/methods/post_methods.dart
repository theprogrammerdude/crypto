import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class PostMethods {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final uuid = const Uuid();

  Future createPost(String post, String uid) {
    String postId = uuid.v4().split('-').join();

    _db.collection('posts').doc(postId).set({
      'post': post,
      'uid': uid,
      'postId': postId,
      'createdAt': DateTime.now().millisecondsSinceEpoch
    });

    return _db.doc('users/$uid').collection('posts').doc(postId).set({
      'post': post,
      'uid': uid,
      'postId': postId,
      'createdAt': DateTime.now().millisecondsSinceEpoch
    });
  }

  Stream<QuerySnapshot> getAllPosts() {
    return _db.collection('posts').snapshots();
  }

  Stream<QuerySnapshot> getUserPosts(String uid) {
    return _db.doc('users/$uid').collection('posts').snapshots();
  }

  Future addComment(String comment, String uid, String postId) {
    String commentId = uuid.v4().split('-').join();

    return _db.doc('posts/$postId').collection('comments').doc(commentId).set({
      'comment': comment,
      'uid': uid,
      'commentId': commentId,
      'at': DateTime.now().millisecondsSinceEpoch
    });
  }

  Stream<QuerySnapshot> getPostComments(String postId) {
    return _db.doc('posts/$postId').collection('comments').snapshots();
  }
}
