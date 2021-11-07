import 'package:crypto_social/pages/btc.dart';
import 'package:crypto_social/pages/inr.dart';
import 'package:crypto_social/pages/usdt.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                icon: FaIcon(FontAwesomeIcons.rupeeSign),
              ),
              Tab(
                icon: FaIcon(FontAwesomeIcons.btc),
              ),
              Tab(
                icon: FaIcon(FontAwesomeIcons.dollarSign),
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
