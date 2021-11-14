import 'package:crypto_plus/pages/btc.dart';
import 'package:crypto_plus/pages/forex.dart';
import 'package:crypto_plus/pages/inr.dart';
import 'package:crypto_plus/pages/usdt.dart';
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
        backgroundColor: Vx.gray300,
        appBar: AppBar(
          title: 'Market'.text.make(),
          actions: [
            IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Forex())),
                icon: const FaIcon(FontAwesomeIcons.exchangeAlt)),
          ],
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
