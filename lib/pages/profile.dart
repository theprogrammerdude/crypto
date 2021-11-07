import 'package:avatars/avatars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_social/methods/auth_methods.dart';
import 'package:crypto_social/methods/db_methods.dart';
import 'package:crypto_social/models/user_model.dart';
import 'package:crypto_social/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:velocity_x/velocity_x.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final DbMethods _dbMethods = DbMethods();
  final AuthMethods _authMethods = AuthMethods();

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
                        ],
                      ),
                      SettingsSection(
                        title: 'Wallet Info',
                        tiles: [
                          SettingsTile(
                            title: 'Balance',
                            subtitle: _user.amount.toString(),
                            leading: const Icon(Icons.account_balance_wallet),
                          ),
                          SettingsTile(
                            title: 'Net Commission',
                            subtitle: _user.netCommission.toString(),
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
                        tiles: const [
                          SettingsTile(
                            title: 'Posts',
                            subtitle: '0',
                            leading: Icon(Icons.article),
                          ),
                          SettingsTile(
                            title: 'Trades',
                            subtitle: '0',
                            leading: FaIcon(FontAwesomeIcons.chartLine),
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
                  ).p12(),
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
