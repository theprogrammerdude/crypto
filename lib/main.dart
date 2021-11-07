import 'package:crypto_social/methods/auth_methods.dart';
import 'package:crypto_social/pages/home.dart';
import 'package:crypto_social/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterLibphonenumber().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthMethods _authMethods = AuthMethods();

    return MaterialApp(
      title: 'Market',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.varelaRound().fontFamily,
        primarySwatch: Colors.deepPurple,
      ),
      home: _authMethods.currentUser() == null ? const Login() : const Home(),
    );
  }
}
