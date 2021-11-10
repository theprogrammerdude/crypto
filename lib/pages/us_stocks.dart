import 'dart:convert';

import 'package:crypto_social/methods/api.dart';
import 'package:crypto_social/models/us_market_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:velocity_x/velocity_x.dart';

class UsStocks extends StatefulWidget {
  const UsStocks({Key? key}) : super(key: key);

  @override
  _UsStocksState createState() => _UsStocksState();
}

class _UsStocksState extends State<UsStocks> {
  final API _api = API();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _api.stocks.length,
      itemBuilder: (context, index) {
        return StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 2))
                .asyncMap((i) => _api.usStockQuotes(_api.stocks[index])),
            builder: (context, AsyncSnapshot<Response> snapshot) {
              Map<String, dynamic> data = jsonDecode(snapshot.data!.body);
              UsMarketModel _usMarketModel = UsMarketModel.fromMap(data);

              // print(_usMarketModel);

              return Card(
                  shape: const Border(
                    left: BorderSide(color: Vx.blue800, width: 5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _api.stocks[index].toString().text.bold.size(24).make(),
                      Row(
                        children: [
                          const FaIcon(FontAwesomeIcons.dollarSign),
                          _usMarketModel.c.toString().text.size(20).make(),
                        ],
                      )
                    ],
                  ).p12());
            });
      },
    );
  }
}
