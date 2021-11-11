import 'dart:convert';

import 'package:crypto_plus/methods/api.dart';
import 'package:crypto_plus/methods/auth_methods.dart';
import 'package:crypto_plus/methods/db_methods.dart';
import 'package:crypto_plus/models/market_model.dart';
import 'package:crypto_plus/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:velocity_x/velocity_x.dart';

class BuyWidget extends StatefulWidget {
  const BuyWidget({Key? key, required this.coinData}) : super(key: key);

  final MarketModel coinData;

  @override
  _BuyWidgetState createState() => _BuyWidgetState();
}

class _BuyWidgetState extends State<BuyWidget> {
  final API _api = API();
  final DbMethods _dbMethods = DbMethods();
  final AuthMethods _authMethods = AuthMethods();

  final GlobalKey<SlideActionState> _key = GlobalKey();

  final TextEditingController _amountController =
      TextEditingController(text: '0');
  final TextEditingController _coinController =
      TextEditingController(text: '0');

  UserModel? _user;
  num rate = 0;

  @override
  void initState() {
    _dbMethods.getUserData(_authMethods.getUid()).listen((event) {
      _user = UserModel.fromMap(event.data() as Map<String, dynamic>);
      // print(_user);
    });

    _api.convertRate(widget.coinData.quoteMarket).then((value) {
      Map<String, dynamic> convertData = jsonDecode(value.body);

      rate = convertData['result'];
    });

    super.initState();
  }

  _buy() {
    num amount = num.parse(_amountController.text) * rate;

    amount < _user!.amount
        ? (amount != 0 && num.parse(_coinController.text) != 0)
            ? _dbMethods
                .buy(
                widget.coinData,
                _authMethods.getUid(),
                num.parse(_coinController.text),
                amount,
              )
                .then((value) {
                _dbMethods.updateUserOnTrade(_user!, amount);
                Navigator.pop(context);
                showTopSnackBar(
                  context,
                  const CustomSnackBar.success(
                    message: "Trade Placed Successfully",
                  ),
                );
              }).catchError((err) {
                _key.currentState!.reset();
                showTopSnackBar(
                  context,
                  const CustomSnackBar.error(
                    message: "Something went wrong.",
                  ),
                );
              })
            : {
                _key.currentState!.reset(),
                showTopSnackBar(
                  context,
                  const CustomSnackBar.error(
                    message: "Fill at least one field",
                  ),
                ),
              }
        : {
            _key.currentState!.reset(),
            showTopSnackBar(
              context,
              const CustomSnackBar.error(
                message: "Funds Insufficient",
              ),
            ),
          };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Vx.blue600),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
            labelText: 'Amount',
            labelStyle: TextStyle(color: Vx.black),
          ),
          onTap: () => _amountController.selection = TextSelection(
              baseOffset: 0, extentOffset: _amountController.value.text.length),
          keyboardType: TextInputType.number,
          controller: _amountController,
          onChanged: (val) => _coinController.text =
              (num.parse(_amountController.text) /
                      num.parse(widget.coinData.sell))
                  .toStringAsFixed(5),
        ).pSymmetric(v: 5),
        TextFormField(
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Vx.blue600),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
            labelText: 'Coins',
            labelStyle: TextStyle(color: Vx.black),
          ),
          onTap: () => _coinController.selection = TextSelection(
              baseOffset: 0, extentOffset: _coinController.value.text.length),
          keyboardType: TextInputType.number,
          controller: _coinController,
          onChanged: (val) => _amountController.text =
              (num.parse(_coinController.text) *
                      num.parse(widget.coinData.sell))
                  .toStringAsFixed(3),
        ).pSymmetric(v: 5),
        Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SlideAction(
                key: _key,
                onSubmit: () => _buy(),
                outerColor: Vx.blue600,
                text: "Buy order",
              ),
            );
          },
        ),
      ],
    );
  }
}
