import 'package:crypto/pages/btc.dart';
import 'package:crypto/pages/inr.dart';
import 'package:crypto/pages/usdt.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Market extends StatefulWidget {
  const Market({Key? key}) : super(key: key);

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: 'Market'.text.make(),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'INR',
              ),
              Tab(
                text: 'BTC',
              ),
              Tab(
                text: 'USDT',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            INR(),
            BTC(),
            USDT(),
          ],
        ),
      ),
    );
  }
}
