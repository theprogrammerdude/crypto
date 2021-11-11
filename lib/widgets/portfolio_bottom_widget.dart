import 'dart:convert';

import 'package:crypto_plus/methods/api.dart';
import 'package:crypto_plus/models/market_model.dart';
import 'package:crypto_plus/models/trade_model.dart';
import 'package:crypto_plus/widgets/square_off_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class PortfolioBottomWidget extends StatefulWidget {
  const PortfolioBottomWidget({Key? key, required this.trade})
      : super(key: key);

  final TradeModel trade;

  @override
  _PortfolioBottomWidgetState createState() => _PortfolioBottomWidgetState();
}

class _PortfolioBottomWidgetState extends State<PortfolioBottomWidget> {
  final API _api = API();

  MarketModel? _coinData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(microseconds: 50))
          .asyncMap((i) => _api.getMarketStatus()),
      builder: (context, AsyncSnapshot<Response> snapshot) {
        if (snapshot.hasData) {
          var data = jsonDecode(snapshot.data!.body);
          List markets = data['markets'];

          for (var element in markets) {
            if (element['low'] != null &&
                element['quoteMarket'] == widget.trade.quoteMarket &&
                element['baseMarket'] == widget.trade.baseMarket) {
              _coinData = MarketModel.fromMap(element);
            }
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.trade.trade == 'buy'
                      ? (_coinData!.baseMarket + '/' + _coinData!.quoteMarket)
                          .text
                          .uppercase
                          .bold
                          .blue600
                          .size(24)
                          .make()
                          .pSymmetric(h: 10)
                      : (_coinData!.baseMarket + '/' + _coinData!.quoteMarket)
                          .text
                          .uppercase
                          .bold
                          .red600
                          .size(24)
                          .make()
                          .pSymmetric(h: 10),
                ],
              ).p8(),
              DateFormat.yMMMd()
                  .add_jm()
                  .format(DateTime.fromMillisecondsSinceEpoch(widget.trade.at))
                  .toString()
                  .text
                  .make()
                  .objectCenterRight(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Amount / Coins'.text.size(16).make(),
                  Row(
                    children: [
                      widget.trade.quoteMarket == 'inr'
                          ? const FaIcon(
                              FontAwesomeIcons.rupeeSign,
                              size: 16,
                            ).pSymmetric(h: 5)
                          : widget.trade.quoteMarket == 'btc'
                              ? const FaIcon(
                                  FontAwesomeIcons.btc,
                                  size: 16,
                                ).pSymmetric(h: 5)
                              : const FaIcon(
                                  FontAwesomeIcons.dollarSign,
                                  size: 16,
                                ).pSymmetric(h: 5),
                      (widget.trade.amount.toString() +
                              ' / ' +
                              widget.trade.coins.toString())
                          .text
                          .size(16)
                          .make()
                    ],
                  ).p8(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      (widget.trade.quoteMarket == 'inr')
                          ? const FaIcon(
                              FontAwesomeIcons.rupeeSign,
                              color: Vx.red600,
                            ).pSymmetric(h: 5)
                          : (widget.trade.quoteMarket == 'btc')
                              ? const FaIcon(
                                  FontAwesomeIcons.btc,
                                  color: Vx.red600,
                                ).pSymmetric(h: 5)
                              : const FaIcon(
                                  FontAwesomeIcons.dollarSign,
                                  color: Vx.red600,
                                ).pSymmetric(h: 5),
                      (widget.trade.quoteMarket == 'btc')
                          ? num.parse(_coinData!.buy)
                              .text
                              .bold
                              .red600
                              .size(24)
                              .make()
                          : NumberFormat.decimalPattern('en-IN')
                              .format(num.parse(_coinData!.buy))
                              .text
                              .bold
                              .red600
                              .size(20)
                              .make()
                    ],
                  ),
                  Row(
                    children: [
                      (widget.trade.quoteMarket == 'inr')
                          ? const FaIcon(
                              FontAwesomeIcons.rupeeSign,
                              color: Vx.blue600,
                            ).pSymmetric(h: 5)
                          : (widget.trade.quoteMarket == 'btc')
                              ? const FaIcon(
                                  FontAwesomeIcons.btc,
                                  color: Vx.blue600,
                                ).pSymmetric(h: 5)
                              : const FaIcon(
                                  FontAwesomeIcons.dollarSign,
                                  color: Vx.blue600,
                                ).pSymmetric(h: 5),
                      (widget.trade.quoteMarket == 'btc')
                          ? num.parse(_coinData!.sell)
                              .text
                              .bold
                              .blue600
                              .size(24)
                              .make()
                          : NumberFormat.decimalPattern('en-IN')
                              .format(num.parse(_coinData!.sell))
                              .text
                              .bold
                              .blue600
                              .size(20)
                              .make()
                    ],
                  ),
                ],
              ).pSymmetric(v: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ('H ' + _coinData!.high).text.bold.size(15).make(),
                  ('L ' + _coinData!.low).text.bold.size(15).make(),
                  ('V ' + _coinData!.volume).text.bold.size(15).make(),
                ],
              ).pSymmetric(v: 5),
              SquareOffWidget(
                trade: widget.trade,
                coinData: _coinData!,
              ).pSymmetric(v: 10),
            ],
          ).p16();
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
