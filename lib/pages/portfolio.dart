import 'package:crypto_plus/pages/history.dart';
import 'package:crypto_plus/pages/orders.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray300,
      appBar: AppBar(
        title: 'Paper Portfolio'.text.make(),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Orders',
            ),
            Tab(
              text: 'History',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Orders(),
          History(),
        ],
      ),
    );
  }
}
