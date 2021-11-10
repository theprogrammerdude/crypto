import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_social/methods/auth_methods.dart';
import 'package:crypto_social/methods/db_methods.dart';
import 'package:crypto_social/models/history_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final AuthMethods _authMethods = AuthMethods();
  final DbMethods _dbMethods = DbMethods();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _dbMethods.getHistory(_authMethods.getUid()),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.size != 0) {
          List<HistoryModel> history = [];

          for (var element in snapshot.data!.docs) {
            HistoryModel _historyModel =
                HistoryModel.fromMap(element.data() as Map<String, dynamic>);

            history.add(_historyModel);
          }

          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                // onTap: () => openBottomSheet(history[index]),
                child: Card(
                  shape: history[index].trade == 'buy'
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
                          (history[index].baseMarket +
                                  '/' +
                                  history[index].quoteMarket)
                              .text
                              .bold
                              .uppercase
                              .size(24)
                              .make(),
                          history[index].trade == 'buy'
                              ? Row(
                                  children: [
                                    history[index].quoteMarket == 'inr'
                                        ? const FaIcon(
                                            FontAwesomeIcons.rupeeSign,
                                            color: Vx.blue600,
                                          ).pSymmetric(h: 5)
                                        : history[index].quoteMarket == 'btc'
                                            ? const FaIcon(
                                                FontAwesomeIcons.btc,
                                                color: Vx.blue600,
                                              ).pSymmetric(h: 5)
                                            : const FaIcon(
                                                FontAwesomeIcons.dollarSign,
                                                color: Vx.blue600,
                                              ).pSymmetric(h: 5),
                                    history[index]
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
                                    history[index].quoteMarket == 'inr'
                                        ? const FaIcon(
                                            FontAwesomeIcons.rupeeSign,
                                            color: Vx.red600,
                                          ).pSymmetric(h: 5)
                                        : history[index].quoteMarket == 'btc'
                                            ? const FaIcon(
                                                FontAwesomeIcons.btc,
                                                color: Vx.red600,
                                              ).pSymmetric(h: 5)
                                            : const FaIcon(
                                                FontAwesomeIcons.dollarSign,
                                                color: Vx.red600,
                                              ).pSymmetric(h: 5),
                                    history[index]
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          history[index].trade == 'buy'
                              ? (history[index].prevSell < history[index].buy
                                  ? ((history[index].prevSell -
                                              history[index].buy) *
                                          history[index].coins)
                                      .toStringAsFixed(3)
                                      .text
                                      .bold
                                      .red600
                                      .size(16)
                                      .make()
                                  : ((history[index].buy -
                                              history[index].prevSell) *
                                          history[index].coins)
                                      .toStringAsFixed(3)
                                      .text
                                      .bold
                                      .blue600
                                      .size(16)
                                      .make())
                              : (history[index].prevBuy < history[index].sell
                                  ? ((history[index].prevBuy -
                                              history[index].sell) *
                                          history[index].coins)
                                      .toStringAsFixed(3)
                                      .text
                                      .bold
                                      .blue600
                                      .size(16)
                                      .make()
                                  : ((history[index].sell -
                                              history[index].prevBuy) *
                                          history[index].coins)
                                      .toStringAsFixed(3)
                                      .text
                                      .bold
                                      .red600
                                      .size(16)
                                      .make()),
                          Row(
                            children: [
                              history[index].quoteMarket == 'inr'
                                  ? const FaIcon(
                                      FontAwesomeIcons.rupeeSign,
                                      size: 16,
                                    ).pSymmetric(h: 5)
                                  : history[index].quoteMarket == 'btc'
                                      ? const FaIcon(
                                          FontAwesomeIcons.btc,
                                          size: 16,
                                        ).pSymmetric(h: 5)
                                      : const FaIcon(
                                          FontAwesomeIcons.dollarSign,
                                          size: 16,
                                        ).pSymmetric(h: 5),
                              (history[index].amount.toStringAsFixed(3) +
                                      ' / ' +
                                      history[index].coins.toString())
                                  .text
                                  .size(16)
                                  .make(),
                            ],
                          )
                        ],
                      ).pSymmetric(v: 5),
                    ],
                  ).p16(),
                ),
              );
            },
          );
        }

        return 'You haven\'t made any orders yet!'
            .text
            .size(20)
            .make()
            .centered();
      },
    );
  }
}
