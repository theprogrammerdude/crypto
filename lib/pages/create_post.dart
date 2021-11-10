import 'package:avatars/avatars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_social/methods/auth_methods.dart';
import 'package:crypto_social/methods/db_methods.dart';
import 'package:crypto_social/methods/post_methods.dart';
import 'package:crypto_social/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:velocity_x/velocity_x.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final AuthMethods _authMethods = AuthMethods();
  final DbMethods _dbMethods = DbMethods();
  final PostMethods _postMethods = PostMethods();

  final TextEditingController _postController = TextEditingController();

  _create() {
    if (_postController.text.isNotEmpty) {
      _postMethods
          .createPost(_postController.text, _authMethods.getUid())
          .then((value) {
        Navigator.pop(context);
      });
    } else {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Post Cannot be empty.",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _dbMethods.getUserData(_authMethods.getUid()),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            UserModel _user = UserModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);

            return Scaffold(
              appBar: AppBar(
                title: 'Create Post'.text.make(),
                centerTitle: true,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Avatar(
                        name: _user.firstName + ' ' + _user.lastName,
                        shape: AvatarShape.circle(20),
                      ).pOnly(right: 10),
                      _user.username.text.bold.size(24).make(),
                    ],
                  ),
                  'What do you think about the crypto market?'
                      .text
                      .size(18)
                      .make()
                      .pSymmetric(v: 15),
                  Flexible(
                    child: TextFormField(
                      controller: _postController,
                      decoration: const InputDecoration(
                        hintText: 'Share your thoughts about the market.',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _create(),
                    child: 'Create Post'.text.size(20).make().p12(),
                  )
                      .cornerRadius(40)
                      .wPCT(context: context, widthPCT: 90)
                      .centered()
                      .pSymmetric(v: 10)
                ],
              ).p16(),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
