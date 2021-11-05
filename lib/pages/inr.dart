import 'dart:convert';

import 'package:crypto/api.dart';
import 'package:crypto/models/market_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class INR extends StatefulWidget {
  const INR({Key? key}) : super(key: key);

  @override
  _INRState createState() => _INRState();
}

class _INRState extends State<INR> {
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
            if (element['low'] != null && element['quoteMarket'] == 'inr') {
              MarketModel _market = MarketModel.fromMap(element);

              marketData.add(_market);
              marketData.sort((a, b) => a.toString().compareTo(b.toString()));
            }
          }

          // print(marketData);

          return ListView.builder(
            itemCount: marketData.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (marketData[index].baseMarket +
                            '/' +
                            marketData[index].quoteMarket)
                        .text
                        .uppercase
                        .bold
                        .size(24)
                        .make(),
                    DateFormat.yMMMd()
                        .format(DateTime.fromMillisecondsSinceEpoch(
                            marketData[index].at * 1000))
                        .toString()
                        .text
                        .make()
                        .objectCenterRight(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.rupeeSign,
                              color: Vx.red600,
                            ).pSymmetric(h: 5),
                            NumberFormat.decimalPattern('en-IN')
                                .format(num.parse(marketData[index].buy))
                                .text
                                .bold
                                .red600
                                .size(20)
                                .make(),
                          ],
                        ),
                        Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.rupeeSign,
                              color: Vx.blue600,
                            ).pSymmetric(h: 5),
                            NumberFormat.decimalPattern('en-IN')
                                .format(num.parse(marketData[index].sell))
                                .text
                                .bold
                                .blue600
                                .size(20)
                                .make(),
                          ],
                        ),
                      ],
                    ).pSymmetric(v: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ('H ' + marketData[index].high)
                            .text
                            .bold
                            .size(15)
                            .make(),
                        ('L ' + marketData[index].low)
                            .text
                            .bold
                            .size(15)
                            .make(),
                        ('V ' + marketData[index].volume)
                            .text
                            .bold
                            .size(15)
                            .make(),
                      ],
                    ).pSymmetric(v: 5)
                  ],
                ).p16(),
              );
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
