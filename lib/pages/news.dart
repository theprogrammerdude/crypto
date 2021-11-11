import 'package:crypto_plus/widgets/stocks_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Vx.gray300,
          appBar: AppBar(
            title: 'News'.text.make(),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: 'Stocks'.text.make(),
                ),
                Tab(
                  child: 'Crypto'.text.make(),
                ),
                Tab(
                  child: 'Forex'.text.make(),
                ),
              ],
            ),
          ),
          body: const TabBarView(children: [
            StocksWidget(
              category: 'stocks',
            ),
            StocksWidget(
              category: 'cryptocurrency',
            ),
            StocksWidget(
              category: 'forex',
            ),
          ]),
        ));
  }
}
