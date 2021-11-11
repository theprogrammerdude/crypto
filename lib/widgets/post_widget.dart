import 'package:avatars/avatars.dart';
import 'package:crypto_plus/methods/db_methods.dart';
import 'package:crypto_plus/models/post_model.dart';
import 'package:crypto_plus/models/user_model.dart';
import 'package:crypto_plus/widgets/comment_sheet.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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

  _openBottomSheet() {
    showBarModalBottomSheet(
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: CommentSheet(
            postId: widget.post.postId,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _dbMethods.getUserData(widget.post.uid).listen((event) {
      setState(() {
        _user = UserModel.fromMap(event.data() as Map<String, dynamic>);
      });
    });

    // print(_user);

    return GestureDetector(
      onTap: () => _openBottomSheet(),
      child: Card(
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
      ).p(3),
    );
  }
}
