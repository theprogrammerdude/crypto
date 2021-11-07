import 'dart:convert';

import 'package:crypto_social/methods/api.dart';
import 'package:crypto_social/models/market_model.dart';
import 'package:crypto_social/widgets/buy_widget.dart';
import 'package:crypto_social/widgets/sell_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class BottomWidget extends StatefulWidget {
  const BottomWidget(
      {Key? key, required this.baseMarket, required this.quoteMarket})
      : super(key: key);

  final String baseMarket;
  final String quoteMarket;

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget>
    with SingleTickerProviderStateMixin {
  final API _api = API();

  TabController? _controller;
  MarketModel? _coinData;

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 2);
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
                element['quoteMarket'] == widget.quoteMarket &&
                element['baseMarket'] == widget.baseMarket) {
              _coinData = MarketModel.fromMap(element);
            }
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (_coinData!.baseMarket + '/' + _coinData!.quoteMarket)
                      .text
                      .uppercase
                      .bold
                      .size(24)
                      .make()
                      .pSymmetric(h: 10),
                ],
              ).p8(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      (widget.quoteMarket == 'inr')
                          ? const FaIcon(
                              FontAwesomeIcons.rupeeSign,
                              color: Vx.red600,
                            ).pSymmetric(h: 5)
                          : (widget.quoteMarket == 'btc')
                              ? const FaIcon(
                                  FontAwesomeIcons.btc,
                                  color: Vx.red600,
                                ).pSymmetric(h: 5)
                              : const FaIcon(
                                  FontAwesomeIcons.dollarSign,
                                  color: Vx.red600,
                                ).pSymmetric(h: 5),
                      (widget.quoteMarket == 'btc')
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
                      (widget.quoteMarket == 'inr')
                          ? const FaIcon(
                              FontAwesomeIcons.rupeeSign,
                              color: Vx.blue600,
                            ).pSymmetric(h: 5)
                          : (widget.quoteMarket == 'btc')
                              ? const FaIcon(
                                  FontAwesomeIcons.btc,
                                  color: Vx.blue600,
                                ).pSymmetric(h: 5)
                              : const FaIcon(
                                  FontAwesomeIcons.dollarSign,
                                  color: Vx.blue600,
                                ).pSymmetric(h: 5),
                      (widget.quoteMarket == 'btc')
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
              TabBar(
                controller: _controller,
                labelColor: Vx.black,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(
                    text: 'Sell',
                  ),
                  Tab(
                    text: 'Buy',
                  ),
                ],
              ),
              Flexible(
                child: SizedBox(
                  height: 250,
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      SellWidget(
                        coinData: _coinData!,
                      ).pSymmetric(v: 10),
                      BuyWidget(
                        coinData: _coinData!,
                      ).pSymmetric(v: 10)
                    ],
                  ),
                ),
              ),
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
