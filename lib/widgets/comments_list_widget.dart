import 'package:avatars/avatars.dart';
import 'package:crypto_plus/methods/auth_methods.dart';
import 'package:crypto_plus/methods/db_methods.dart';
import 'package:crypto_plus/models/comment_model.dart';
import 'package:crypto_plus/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsListWidget extends StatefulWidget {
  const CommentsListWidget({Key? key, required this.comments})
      : super(key: key);

  final List<CommentModel> comments;

  @override
  _CommentsListWidgetState createState() => _CommentsListWidgetState();
}

class _CommentsListWidgetState extends State<CommentsListWidget> {
  final DbMethods _dbMethods = DbMethods();
  final AuthMethods _authMethods = AuthMethods();

  UserModel? _user;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.comments.length,
        itemBuilder: (context, index) {
          _dbMethods.getUserData(_authMethods.getUid()).listen((event) {
            _user = UserModel.fromMap(event.data() as Map<String, dynamic>);
          });

          return ListTile(
            leading: Avatar(
              name: _user!.firstName + ' ' + _user!.lastName,
              shape: AvatarShape.circle(20),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _user!.username.text.make(),
                timeago
                    .format(DateTime.fromMillisecondsSinceEpoch(
                        widget.comments[index].at))
                    .text
                    .gray500
                    .size(12)
                    .make()
              ],
            ),
            subtitle: widget.comments[index].comment.text.make(),
          );
        },
      ),
    );
  }
}
