import 'dart:convert';

import 'package:crypto_plus/methods/api.dart';
import 'package:crypto_plus/models/market_model.dart';
import 'package:crypto_plus/widgets/coinlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class USDT extends StatefulWidget {
  const USDT({Key? key}) : super(key: key);

  @override
  _USDTState createState() => _USDTState();
}

class _USDTState extends State<USDT> {
  final API _api = API();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(microseconds: 100))
          .asyncMap((i) => _api.getMarketStatus()),
      builder: (context, AsyncSnapshot<Response> snapshot) {
        if (snapshot.hasData) {
          var data = jsonDecode(snapshot.data!.body);
          List markets = data['markets'];
          List<MarketModel> marketData = [];

          for (var element in markets) {
            if (element['low'] != null &&
                element['quoteMarket'] == 'usdt' &&
                num.parse(element['sell']) != 0 &&
                num.parse(element['buy']) != 0) {
              MarketModel _market = MarketModel.fromMap(element);

              marketData.add(_market);
              marketData.sort((a, b) => a.toString().compareTo(b.toString()));
            }
          }

          // print(marketData);

          return CoinListWidget(marketData: marketData);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
