import 'dart:convert';
import 'dart:io';

import 'package:crypto_plus/methods/api.dart';
import 'package:crypto_plus/models/news_mdel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StocksWidget extends StatefulWidget {
  const StocksWidget({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  _StocksWidgetState createState() => _StocksWidgetState();
}

class _StocksWidgetState extends State<StocksWidget> {
  final API _api = API();

  openBottomSheet(String url) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: WebView(
          initialUrl: url,
        ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _api.getNews(widget.category),
      builder: (context, AsyncSnapshot<Response> snapshot) {
        if (snapshot.hasData) {
          List data = jsonDecode(snapshot.data!.body);
          List<NewsModel> news = [];

          for (var element in data) {
            NewsModel _newsModel = NewsModel.fromMap(element);

            news.add(_newsModel);
          }

          return ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => openBottomSheet(news[index].url),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(imageUrl: news[index].image),
                      news[index]
                          .headline
                          .text
                          .size(24)
                          .make()
                          .pSymmetric(v: 5),
                      DateFormat.yMMMd()
                          .format(DateTime.fromMillisecondsSinceEpoch(
                              news[index].datetime * 1000))
                          .text
                          .make()
                          .objectCenterRight(),
                      news[index].summary.text.make().pSymmetric(v: 5),
                    ],
                  ).p16(),
                ),
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
