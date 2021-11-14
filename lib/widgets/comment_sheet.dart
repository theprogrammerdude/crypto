import 'package:avatars/avatars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_plus/methods/auth_methods.dart';
import 'package:crypto_plus/methods/db_methods.dart';
import 'package:crypto_plus/methods/post_methods.dart';
import 'package:crypto_plus/models/comment_model.dart';
import 'package:crypto_plus/models/user_model.dart';
import 'package:crypto_plus/widgets/comments_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:velocity_x/velocity_x.dart';

class CommentSheet extends StatefulWidget {
  const CommentSheet({Key? key, required this.postId}) : super(key: key);

  final String postId;

  @override
  _CommentSheetState createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final PostMethods _postMethods = PostMethods();
  final DbMethods _dbMethods = DbMethods();
  final AuthMethods _authMethods = AuthMethods();

  final TextEditingController _commentController = TextEditingController();

  UserModel? _user;

  _addComment() {
    if (_commentController.text.isNotEmpty) {
      _postMethods
          .addComment(
              _commentController.text, _authMethods.getUid(), widget.postId)
          .then((value) {
        _commentController.clear();
        VxToast.show(context,
            msg: 'Comment Posted.', position: VxToastPosition.center);
      });
    } else {
      showTopSnackBar(context,
          const CustomSnackBar.error(message: 'You missed something.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    _dbMethods.getUserData(_authMethods.getUid()).listen((event) {
      setState(() {
        _user = UserModel.fromMap(event.data() as Map<String, dynamic>);
      });
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        'Comments'.text.bold.size(24).make(),
        Flexible(
          child: StreamBuilder(
            stream: _postMethods.getPostComments(widget.postId),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                List<CommentModel> comments = [];

                for (var element in snapshot.data!.docs) {
                  CommentModel _comment = CommentModel.fromMap(
                      element.data() as Map<String, dynamic>);

                  comments.add(_comment);
                }

                return CommentsListWidget(
                  comments: comments,
                );
              }

              return 'No Comments Yet.'.text.size(20).make().pSymmetric(v: 10);
            },
          ).pSymmetric(v: 10),
        ),
        TextFormField(
          decoration: InputDecoration(
            // focusedBorder: const OutlineInputBorder(
            //   borderSide: BorderSide(width: 1, color: Vx.blue600),
            // ),
            // enabledBorder: const OutlineInputBorder(
            //   borderSide: BorderSide(width: 1),
            // ),
            prefixIcon: Avatar(
              name: _user!.firstName + ' ' + _user!.lastName,
              shape: AvatarShape.circle(20),
            ).p4(),
            suffixIcon: IconButton(
                onPressed: () => _addComment(), icon: const Icon(Icons.send)),
            hintText: 'Write a Comment ...',
            labelStyle: const TextStyle(color: Vx.black),
          ),
          maxLength: 100,
          minLines: 1,
          maxLines: 3,
          controller: _commentController,
        ).objectBottomCenter().pOnly(top: 10),
      ],
    ).p8();
  }
}
