import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Feed'.text.make(),
      ),
    );
  }
}
