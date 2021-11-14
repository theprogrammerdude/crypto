import 'package:crypto_plus/widgets/forex_rates_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Forex extends StatefulWidget {
  const Forex({Key? key}) : super(key: key);

  @override
  _ForexState createState() => _ForexState();
}

class _ForexState extends State<Forex> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray300,
      appBar: AppBar(
        title: 'Forex'.text.make(),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'INR',
            ),
            Tab(
              text: 'USD',
            ),
            Tab(
              text: 'EUR',
            ),
            Tab(
              text: 'GBP',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ForexRatesWidget(currency: 'inr'),
          ForexRatesWidget(currency: 'usd'),
          ForexRatesWidget(currency: 'eur'),
          ForexRatesWidget(currency: 'gbp'),
        ],
      ),
    );
  }
}
