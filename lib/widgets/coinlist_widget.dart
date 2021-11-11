import 'package:crypto_plus/models/market_model.dart';
import 'package:crypto_plus/widgets/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:velocity_x/velocity_x.dart';

class CoinListWidget extends StatefulWidget {
  const CoinListWidget({Key? key, required this.marketData}) : super(key: key);

  final List<MarketModel> marketData;

  @override
  _CoinListWidgetState createState() => _CoinListWidgetState();
}

class _CoinListWidgetState extends State<CoinListWidget> {
  openBottomSheet(String baseMarket, String quoteMarket) {
    showBarModalBottomSheet(
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: BottomWidget(
            baseMarket: baseMarket,
            quoteMarket: quoteMarket,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.marketData.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => openBottomSheet(widget.marketData[index].baseMarket,
              widget.marketData[index].quoteMarket),
          child: Card(
            shape: const Border(
              left: BorderSide(color: Vx.blue800, width: 5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (widget.marketData[index].baseMarket +
                        '/' +
                        widget.marketData[index].quoteMarket)
                    .text
                    .uppercase
                    .bold
                    .size(24)
                    .make(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        (widget.marketData[index].quoteMarket == 'inr')
                            ? const FaIcon(
                                FontAwesomeIcons.rupeeSign,
                                color: Vx.red600,
                              ).pSymmetric(h: 5)
                            : (widget.marketData[index].quoteMarket == 'btc')
                                ? const FaIcon(
                                    FontAwesomeIcons.btc,
                                    color: Vx.red600,
                                  ).pSymmetric(h: 5)
                                : const FaIcon(
                                    FontAwesomeIcons.dollarSign,
                                    color: Vx.red600,
                                  ).pSymmetric(h: 5),
                        (widget.marketData[index].quoteMarket == 'btc')
                            ? num.parse(widget.marketData[index].buy)
                                .text
                                .bold
                                .red600
                                .size(20)
                                .make()
                            : NumberFormat.decimalPattern('en-IN')
                                .format(num.parse(widget.marketData[index].buy))
                                .text
                                .bold
                                .red600
                                .size(20)
                                .make()
                      ],
                    ),
                    Row(
                      children: [
                        (widget.marketData[index].quoteMarket == 'inr')
                            ? const FaIcon(
                                FontAwesomeIcons.rupeeSign,
                                color: Vx.blue600,
                              ).pSymmetric(h: 5)
                            : (widget.marketData[index].quoteMarket == 'btc')
                                ? const FaIcon(
                                    FontAwesomeIcons.btc,
                                    color: Vx.blue600,
                                  ).pSymmetric(h: 5)
                                : const FaIcon(
                                    FontAwesomeIcons.dollarSign,
                                    color: Vx.blue600,
                                  ).pSymmetric(h: 5),
                        (widget.marketData[index].quoteMarket == 'btc')
                            ? num.parse(widget.marketData[index].sell)
                                .text
                                .bold
                                .blue600
                                .size(20)
                                .make()
                            : NumberFormat.decimalPattern('en-IN')
                                .format(
                                    num.parse(widget.marketData[index].sell))
                                .text
                                .bold
                                .blue600
                                .size(20)
                                .make()
                      ],
                    ),
                  ],
                ).pSymmetric(v: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ('H ' + widget.marketData[index].high)
                        .text
                        .bold
                        .size(15)
                        .make(),
                    ('L ' + widget.marketData[index].low)
                        .text
                        .bold
                        .size(15)
                        .make(),
                    ('V ' + widget.marketData[index].volume)
                        .text
                        .bold
                        .size(15)
                        .make(),
                  ],
                ).pSymmetric(v: 5),
              ],
            ).p16(),
          ),
        );
      },
    );
  }
}
