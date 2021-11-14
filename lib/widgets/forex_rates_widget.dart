import 'dart:convert';

import 'package:crypto_plus/methods/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:velocity_x/velocity_x.dart';

class ForexRatesWidget extends StatefulWidget {
  const ForexRatesWidget({Key? key, required this.currency}) : super(key: key);

  final String currency;

  @override
  _ForexRatesWidgetState createState() => _ForexRatesWidgetState();
}

class _ForexRatesWidgetState extends State<ForexRatesWidget> {
  final API _api = API();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _api.forexRates(widget.currency),
      builder: (context, AsyncSnapshot<Response> snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data = jsonDecode(snapshot.data!.body);
          Map<String, dynamic> rates = data['rates'];
          List<Map<String, dynamic>> forex = [];

          rates.forEach((key, value) {
            forex.add({'name': key, 'rate': value});
          });

          return ListView.builder(
            itemCount: forex.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: (widget.currency.toUpperCase() +
                          '/' +
                          forex[index]['name'].toString())
                      .text
                      .bold
                      .size(20)
                      .make(),
                  subtitle: forex[index]['rate'].toString().text.bold.make(),
                  leading: widget.currency == 'inr'
                      ? const FaIcon(FontAwesomeIcons.rupeeSign)
                      : widget.currency == 'usd'
                          ? const FaIcon(FontAwesomeIcons.dollarSign)
                          : widget.currency == 'eur'
                              ? const FaIcon(FontAwesomeIcons.euroSign)
                              : const FaIcon(FontAwesomeIcons.poundSign),
                ).p8(),
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
