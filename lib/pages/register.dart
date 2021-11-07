import 'package:crypto_social/methods/auth_methods.dart';
import 'package:crypto_social/methods/db_methods.dart';
import 'package:crypto_social/pages/home.dart';
import 'package:crypto_social/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:velocity_x/velocity_x.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthMethods _authMethods = AuthMethods();
  final DbMethods _dbMethods = DbMethods();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  String phone = '';

  _register(String email, String password) {
    try {
      _authMethods.signup(email, password).then((value) {
        _dbMethods.addUser(
            _firstNameController.text.toLowerCase(),
            _lastNameController.text.toLowerCase(),
            email,
            value.user!.uid,
            _phoneController.text);

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
              'Create a new Account'
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
                      labelText: 'First Name',
                      labelStyle: TextStyle(color: Vx.black),
                    ),
                    controller: _firstNameController,
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
                      labelText: 'Last Name',
                      labelStyle: TextStyle(color: Vx.black),
                    ),
                    controller: _lastNameController,
                  ).pSymmetric(v: 5),
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      setState(() {
                        phone = number.phoneNumber!;
                      });
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    initialValue: number,
                    textFieldController: _phoneController,
                    formatInput: true,
                    maxLength: 10,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputBorder: const OutlineInputBorder(),
                  ),
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
                    _register(_emailController.text, _passwordController.text),
                color: Colors.deepPurple,
                child: 'Create Account'.text.size(18).make(),
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
                              builder: (context) => const Login())),
                      child:
                          'Go to Login'.text.size(18).make().pSymmetric(v: 15))
                  .wPCT(context: context, widthPCT: 75),
            ],
          ).p12(),
        ),
      ),
    );
  }
}
