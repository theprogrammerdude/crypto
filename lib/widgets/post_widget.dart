import 'package:avatars/avatars.dart';
import 'package:crypto_social/methods/db_methods.dart';
import 'package:crypto_social/models/post_model.dart';
import 'package:crypto_social/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatefulWidget {
  const PostWidget({Key? key, required this.post}) : super(key: key);

  final PostModel post;

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final DbMethods _dbMethods = DbMethods();

  UserModel? _user;

  @override
  Widget build(BuildContext context) {
    _dbMethods.getUserData(widget.post.uid).listen((event) {
      setState(() {
        _user = UserModel.fromMap(event.data() as Map<String, dynamic>);
      });
    });

    // print(_user);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Avatar(
                name: _user!.firstName + ' ' + _user!.lastName,
                shape: AvatarShape.circle(20),
              ).pOnly(right: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _user!.username.text.bold.size(20).make(),
                  timeago
                      .format(DateTime.fromMillisecondsSinceEpoch(
                          widget.post.createdAt))
                      .text
                      .make(),
                ],
              ),
            ],
          ),
          widget.post.post.text.size(18).make().p(10),
        ],
      ).p8(),
    ).p(5);
  }
}
