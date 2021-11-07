import 'package:http/http.dart' as http;

class API {
  // static const String CMC_API_KEY = '741ef89c-50ba-4dc2-ba8f-c63365bc49c8';

  Future<http.Response> getMarketStatus() async {
    var url = Uri.parse('https://api.wazirx.com/api/v2/market-status');
    var res = await http.get(url);

    return res;
  }

  // Future<http.Response> getCoinInfo(String coinName) async {
  //   var url = Uri.parse(
  //       'https://pro-api.coinmarketcap.com/v1/cryptocurrency/info?CMC_PRO_API_KEY=$CMC_API_KEY&symbol=$coinName');
  //   var res = await http.get(url);

  //   return res;
  // }

  Future<http.Response> getMarketDepth(
      String baseMarket, String quoteMarket) async {
    String ticker = baseMarket + quoteMarket;

    var url = Uri.parse('https://api.wazirx.com/api/v2/depth?market=$ticker');
    var res = await http.get(url);

    return res;
  }
}
