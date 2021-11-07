import 'package:crypto_social/methods/auth_methods.dart';
import 'package:crypto_social/methods/db_methods.dart';
import 'package:crypto_social/models/market_model.dart';
import 'package:crypto_social/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:velocity_x/velocity_x.dart';

class SellWidget extends StatefulWidget {
  const SellWidget({Key? key, required this.coinData}) : super(key: key);

  final MarketModel coinData;

  @override
  _SellWidgetState createState() => _SellWidgetState();
}

class _SellWidgetState extends State<SellWidget> {
  final DbMethods _dbMethods = DbMethods();
  final AuthMethods _authMethods = AuthMethods();

  final GlobalKey<SlideActionState> _key = GlobalKey();

  final TextEditingController _amountController =
      TextEditingController(text: '0');
  final TextEditingController _coinController =
      TextEditingController(text: '0');

  UserModel? _user;

  @override
  void initState() {
    _dbMethods.getUserData(_authMethods.getUid()).listen((event) {
      _user = UserModel.fromMap(event.data() as Map<String, dynamic>);
      // print(_user);
    });

    super.initState();
  }

  _sell() {
    num.parse(_amountController.text) < _user!.amount
        ? (num.parse(_amountController.text) != 0 &&
                num.parse(_coinController.text) != 0)
            ? _dbMethods
                .sell(widget.coinData, _authMethods.getUid(),
                    num.parse(_coinController.text))
                .then((value) {
                Navigator.pop(context);
                showTopSnackBar(
                  context,
                  const CustomSnackBar.success(
                    message: "Trade Placed Successfully 🎉🎉🎉",
                  ),
                );
              }).catchError((err) {
                _key.currentState!.reset();
                showTopSnackBar(
                  context,
                  const CustomSnackBar.error(
                    message: "Something went wrong. 😓😓😓",
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
                      num.parse(widget.coinData.buy))
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
              (num.parse(_coinController.text) * num.parse(widget.coinData.buy))
                  .toStringAsFixed(3),
        ).pSymmetric(v: 5),
        Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SlideAction(
                key: _key,
                onSubmit: () => _sell(),
                outerColor: Vx.red600,
                text: "Sell order",
              ),
            );
          },
        ),
      ],
    );
  }
}