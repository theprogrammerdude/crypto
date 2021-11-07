import 'package:crypto_social/methods/auth_methods.dart';
import 'package:crypto_social/pages/home.dart';
import 'package:crypto_social/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:velocity_x/velocity_x.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthMethods _authMethods = AuthMethods();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  _login(String email, String password) {
    try {
      _authMethods.signin(email, password).then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/login.svg',
              ),
              'Login to your Account'
                  .text
                  .uppercase
                  .purple600
                  .bold
                  .center
                  .size(20)
                  .make()
                  .p12(),
              Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.deepPurple),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Vx.black),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                  ).pSymmetric(v: 5),
                  TextFormField(
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.deepPurple),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Vx.black),
                    ),
                    obscureText: true,
                    controller: _passwordController,
                  ).pSymmetric(v: 5),
                ],
              ),
              RoundedLoadingButton(
                controller: _btnController,
                onPressed: () =>
                    _login(_emailController.text, _passwordController.text),
                color: Colors.deepPurple,
                child: 'Login'.text.size(18).make(),
              ).pSymmetric(v: 10),
              OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        side: const BorderSide(
                            width: 2.0, color: Colors.deepPurple),
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register())),
                      child: 'Create an Account'
                          .text
                          .size(18)
                          .make()
                          .pSymmetric(v: 15))
                  .wPCT(context: context, widthPCT: 75),
            ],
          ).p12(),
        ),
      ),
    );
  }
}
