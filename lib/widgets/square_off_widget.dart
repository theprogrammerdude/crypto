import 'dart:convert';

import 'package:crypto_plus/methods/api.dart';
import 'package:crypto_plus/methods/auth_methods.dart';
import 'package:crypto_plus/methods/db_methods.dart';
import 'package:crypto_plus/models/market_model.dart';
import 'package:crypto_plus/models/trade_model.dart';
import 'package:crypto_plus/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:velocity_x/velocity_x.dart';

class SquareOffWidget extends StatefulWidget {
  const SquareOffWidget({Key? key, required this.trade, required this.coinData})
      : super(key: key);

  final TradeModel trade;
  final MarketModel coinData;

  @override
  _SquareOffWidgetState createState() => _SquareOffWidgetState();
}

class _SquareOffWidgetState extends State<SquareOffWidget> {
  final API _api = API();
  final DbMethods _dbMethods = DbMethods();
  final AuthMethods _authMethods = AuthMethods();

  final GlobalKey<SlideActionState> _key = GlobalKey();

  TextEditingController? _coinController;
  num rate = 0;
  UserModel? _user;

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

    _coinController =
        TextEditingController(text: widget.trade.coins.toString());

    super.initState();
  }

  squareOff(num coins) {
    if (widget.trade.trade == 'buy') {
      _dbMethods.squareOff(widget.trade, widget.coinData, _authMethods.getUid(),
          coins, coins * widget.trade.buy * rate, 'buy');

      _dbMethods.deleteTrade(_authMethods.getUid(), widget.trade.transactionId);

      _dbMethods.updateUserOnSquareOff(
          _user!, coins * num.parse(widget.coinData.buy) * rate);

      Navigator.pop(context);
      showTopSnackBar(
        context,
        const CustomSnackBar.success(
          message: "Trade Placed Successfully",
        ),
      );
    } else {
      _dbMethods.squareOff(widget.trade, widget.coinData, _authMethods.getUid(),
          coins, coins * widget.trade.buy * rate, 'sell');

      _dbMethods.deleteTrade(_authMethods.getUid(), widget.trade.transactionId);

      _dbMethods.updateUserOnSquareOff(
          _user!, coins * num.parse(widget.coinData.sell) * rate);

      Navigator.pop(context);
      showTopSnackBar(
        context,
        const CustomSnackBar.success(
          message: "Trade Placed Successfully",
        ),
      );
    }
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
            labelText: 'Coins',
            labelStyle: TextStyle(color: Vx.black),
          ),
          enabled: false,
          keyboardType: TextInputType.number,
          controller: _coinController,
        ).pSymmetric(v: 5),
        widget.trade.trade == 'sell'
            ? Builder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SlideAction(
                      key: _key,
                      onSubmit: () =>
                          squareOff(num.parse(_coinController!.text)),
                      outerColor: Vx.blue600,
                      text: "Buy order",
                    ),
                  );
                },
              )
            : Builder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SlideAction(
                      key: _key,
                      onSubmit: () =>
                          squareOff(num.parse(_coinController!.text)),
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
