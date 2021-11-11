import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_plus/methods/auth_methods.dart';
import 'package:crypto_plus/methods/db_methods.dart';
import 'package:crypto_plus/models/trade_model.dart';
import 'package:crypto_plus/widgets/portfolio_bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:velocity_x/velocity_x.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final DbMethods _dbMethods = DbMethods();
  final AuthMethods _authMethods = AuthMethods();

  openBottomSheet(TradeModel trade) {
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
          child: PortfolioBottomWidget(
            trade: trade,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _dbMethods.getAllTrades(_authMethods.getUid()),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.size != 0) {
          List<TradeModel> _trades = [];

          for (var element in snapshot.data!.docs) {
            TradeModel _trade =
                TradeModel.fromMap(element.data() as Map<String, dynamic>);

            _trades.add(_trade);
          }

          // print(_trades);

          return ListView.builder(
            itemCount: _trades.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => openBottomSheet(_trades[index]),
                child: Card(
                  shape: _trades[index].trade == 'buy'
                      ? const Border(
                          left: BorderSide(color: Vx.blue800, width: 5),
                        )
                      : const Border(
                          left: BorderSide(color: Vx.red600, width: 5),
                        ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          (_trades[index].baseMarket +
                                  '/' +
                                  _trades[index].quoteMarket)
                              .text
                              .bold
                              .uppercase
                              .size(24)
                              .make(),
                          _trades[index].trade == 'buy'
                              ? Row(
                                  children: [
                                    _trades[index].quoteMarket == 'inr'
                                        ? const FaIcon(
                                            FontAwesomeIcons.rupeeSign,
                                            color: Vx.blue600,
                                          ).pSymmetric(h: 5)
                                        : _trades[index].quoteMarket == 'btc'
                                            ? const FaIcon(
                                                FontAwesomeIcons.btc,
                                                color: Vx.blue600,
                                              ).pSymmetric(h: 5)
                                            : const FaIcon(
                                                FontAwesomeIcons.dollarSign,
                                                color: Vx.blue600,
                                              ).pSymmetric(h: 5),
                                    _trades[index]
                                        .buy
                                        .text
                                        .bold
                                        .blue600
                                        .size(20)
                                        .make()
                                  ],
                                )
                              : Row(
                                  children: [
                                    _trades[index].quoteMarket == 'inr'
                                        ? const FaIcon(
                                            FontAwesomeIcons.rupeeSign,
                                            color: Vx.red600,
                                          ).pSymmetric(h: 5)
                                        : _trades[index].quoteMarket == 'btc'
                                            ? const FaIcon(
                                                FontAwesomeIcons.btc,
                                                color: Vx.red600,
                                              ).pSymmetric(h: 5)
                                            : const FaIcon(
                                                FontAwesomeIcons.dollarSign,
                                                color: Vx.red600,
                                              ).pSymmetric(h: 5),
                                    _trades[index]
                                        .sell
                                        .text
                                        .bold
                                        .red600
                                        .size(20)
                                        .make()
                                  ],
                                )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _trades[index].quoteMarket == 'inr'
                              ? const FaIcon(
                                  FontAwesomeIcons.rupeeSign,
                                  size: 16,
                                ).pSymmetric(h: 5)
                              : _trades[index].quoteMarket == 'btc'
                                  ? const FaIcon(
                                      FontAwesomeIcons.btc,
                                      size: 16,
                                    ).pSymmetric(h: 5)
                                  : const FaIcon(
                                      FontAwesomeIcons.dollarSign,
                                      size: 16,
                                    ).pSymmetric(h: 5),
                          (_trades[index].amount.toString() +
                                  ' / ' +
                                  _trades[index].coins.toString())
                              .text
                              .size(16)
                              .make(),
                        ],
                      ).pSymmetric(v: 5)
                    ],
                  ).p16(),
                ),
              );
            },
          );
        }

        return Image.asset('assets/404.png').centered();
      },
    );
  }
}
