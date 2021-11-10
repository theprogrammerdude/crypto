import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_social/methods/post_methods.dart';
import 'package:crypto_social/models/post_model.dart';
import 'package:crypto_social/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final PostMethods _postMethods = PostMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray300,
      appBar: AppBar(
        title: 'Feed'.text.make(),
      ),
      body: StreamBuilder(
        stream: _postMethods.getAllPosts(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<PostModel> posts = [];

            for (var element in snapshot.data!.docs) {
              PostModel _postModel =
                  PostModel.fromMap(element.data() as Map<String, dynamic>);

              posts.add(_postModel);
            }

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostWidget(post: posts[index]);
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
