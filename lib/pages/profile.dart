import 'package:avatars/avatars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_plus/methods/auth_methods.dart';
import 'package:crypto_plus/methods/db_methods.dart';
import 'package:crypto_plus/methods/post_methods.dart';
import 'package:crypto_plus/models/post_model.dart';
import 'package:crypto_plus/models/user_model.dart';
import 'package:crypto_plus/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:timeago/timeago.dart' as timeago;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final DbMethods _dbMethods = DbMethods();
  final AuthMethods _authMethods = AuthMethods();
  final PostMethods _postMethods = PostMethods();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List trades = [];
  List posts = [];

  @override
  void initState() {
    _dbMethods.getAllTrades(_authMethods.getUid()).listen((event) {
      for (var element in event.docs) {
        trades.add(element);
      }
    });

    _postMethods.getUserPosts(_authMethods.getUid()).listen((event) {
      for (var element in event.docs) {
        posts.add(element);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _dbMethods.getUserData(_authMethods.getUid()),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          UserModel _user =
              UserModel.fromMap(snapshot.data!.data() as Map<String, dynamic>);

          return Scaffold(
            appBar: AppBar(
              title: _user.username.text.make(),
            ),
            body: Column(
              children: [
                Avatar(
                  name: _user.firstName + ' ' + _user.lastName,
                ).pSymmetric(v: 10),
                Flexible(
                  child: SettingsList(
                    shrinkWrap: true,
                    backgroundColor: Colors.white,
                    sections: [
                      SettingsSection(
                        title: 'Personal Info',
                        tiles: [
                          SettingsTile(
                            onPressed: (context) {
                              showBarModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1, color: Vx.blue600),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1),
                                            ),
                                            labelText: 'First Name',
                                            labelStyle:
                                                TextStyle(color: Vx.black),
                                          ),
                                          keyboardType: TextInputType.name,
                                          controller: _firstNameController
                                            ..text = _user.firstName
                                                .allWordsCapitilize(),
                                        ).pSymmetric(v: 5),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1, color: Vx.blue600),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1),
                                            ),
                                            labelText: 'Last Name',
                                            labelStyle:
                                                TextStyle(color: Vx.black),
                                          ),
                                          keyboardType: TextInputType.name,
                                          controller: _lastNameController
                                            ..text = _user.lastName
                                                .allWordsCapitilize(),
                                        ).pSymmetric(v: 5),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (_firstNameController
                                                    .text.isNotEmpty &&
                                                _lastNameController
                                                    .text.isNotEmpty) {
                                              _dbMethods
                                                  .updateName(
                                                      _firstNameController.text
                                                          .toLowerCase(),
                                                      _lastNameController.text
                                                          .toLowerCase(),
                                                      _authMethods.getUid())
                                                  .then((value) {
                                                Navigator.pop(context);
                                                VxToast.show(context,
                                                    msg:
                                                        'Name Updated Successfully.',
                                                    position:
                                                        VxToastPosition.center);
                                              });
                                            } else {
                                              VxToast.show(context,
                                                  msg:
                                                      'First/Last name can\'t be empty.',
                                                  position:
                                                      VxToastPosition.center);
                                            }
                                          },
                                          child: 'Update'
                                              .text
                                              .size(20)
                                              .make()
                                              .pSymmetric(v: 15),
                                        )
                                            .wPCT(
                                                context: context, widthPCT: 100)
                                            .pSymmetric(v: 10)
                                      ],
                                    ).p16().pOnly(top: 20),
                                  );
                                },
                              );
                            },
                            title: 'Name',
                            subtitle: _user.firstName.allWordsCapitilize() +
                                ' ' +
                                _user.lastName.allWordsCapitilize(),
                            leading: const Icon(Icons.person),
                          ),
                          SettingsTile(
                            title: 'Username',
                            subtitle: _user.username,
                            leading: const Icon(Icons.title),
                          ),
                          SettingsTile(
                            onPressed: (context) {
                              showBarModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1, color: Vx.blue600),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1),
                                            ),
                                            labelText: 'Email',
                                            labelStyle:
                                                TextStyle(color: Vx.black),
                                          ),
                                          keyboardType: TextInputType.name,
                                          controller: _emailController
                                            ..text = _user.email,
                                        ).pSymmetric(v: 5),
                                        ElevatedButton(
                                          onPressed: () => _dbMethods
                                              .updateEmail(
                                                  _emailController.text
                                                      .toLowerCase(),
                                                  _authMethods.getUid())
                                              .then((value) {
                                            Navigator.pop(context);
                                            VxToast.show(context,
                                                msg:
                                                    'Email Updated Successfully.',
                                                position:
                                                    VxToastPosition.center);
                                          }),
                                          child: 'Update'
                                              .text
                                              .size(20)
                                              .make()
                                              .pSymmetric(v: 15),
                                        )
                                            .wPCT(
                                                context: context, widthPCT: 100)
                                            .pSymmetric(v: 10)
                                      ],
                                    ).p16().pOnly(top: 20),
                                  );
                                },
                              );
                            },
                            title: 'Email',
                            subtitle: _user.email,
                            leading: const Icon(Icons.email),
                          ),
                          SettingsTile(
                            title: 'Phone',
                            subtitle: FlutterLibphonenumber()
                                .formatNumberSync(_user.phone),
                            leading: const Icon(Icons.phone_android),
                          ),
                          SettingsTile(
                            title: 'Joined',
                            subtitle: timeago.format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    _user.createdAt)),
                            leading: const Icon(Icons.calendar_today_rounded),
                          ),
                        ],
                      ),
                      SettingsSection(
                        title: 'Wallet Info',
                        tiles: [
                          SettingsTile(
                            title: 'Balance',
                            subtitle: _user.amount.toStringAsFixed(3),
                            leading: const Icon(Icons.account_balance_wallet),
                          ),
                          SettingsTile(
                            title: 'Net Commission',
                            subtitle: _user.netCommission.toStringAsFixed(3),
                            leading: const FaIcon(FontAwesomeIcons.moneyBill),
                          ),
                          SettingsTile(
                            title: 'Commission',
                            subtitle: _user.commission.toString() + '%',
                            leading: const FaIcon(FontAwesomeIcons.percentage),
                          ),
                        ],
                      ),
                      SettingsSection(
                        title: 'Profile Info',
                        tiles: [
                          SettingsTile(
                            onPressed: (context) {
                              showBarModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return StreamBuilder(
                                    stream: _postMethods
                                        .getUserPosts(_authMethods.getUid()),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasData) {
                                        List<PostModel> posts = [];
                                        for (var element
                                            in snapshot.data!.docs) {
                                          PostModel _postModel =
                                              PostModel.fromMap(element.data()
                                                  as Map<String, dynamic>);

                                          posts.add(_postModel);
                                        }

                                        return SizedBox(
                                          height: 150,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: posts.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                child: Column(
                                                  children: [
                                                    Flexible(
                                                        child: posts[index]
                                                            .post
                                                            .text
                                                            .bold
                                                            .size(20)
                                                            .make()),
                                                    timeago
                                                        .format(DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                posts[index]
                                                                    .createdAt))
                                                        .text
                                                        .make()
                                                        .objectBottomRight(),
                                                  ],
                                                ).p12(),
                                              ).wPCT(
                                                  context: context,
                                                  widthPCT: 50);
                                            },
                                          ),
                                        );
                                      }

                                      return ''.text.make();
                                    },
                                  );
                                },
                              );
                            },
                            title: 'Posts',
                            subtitle: posts.length.toString(),
                            leading: const Icon(Icons.article),
                          ),
                          SettingsTile(
                            title: 'Trades',
                            subtitle: trades.length.toString(),
                            leading: const FaIcon(FontAwesomeIcons.chartLine),
                          ),
                        ],
                      ),
                      SettingsSection(
                        title: 'Settings',
                        tiles: [
                          SettingsTile(
                            title: 'Logout',
                            onPressed: (context) {
                              _authMethods.signout().then((value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()),
                                    (route) => false);
                              });
                            },
                            leading: const Icon(Icons.logout_rounded),
                          ),
                        ],
                      )
                    ],
                  ).p8(),
                ),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
