import 'package:http/http.dart' as http;

class API {
  Future<http.Response> getMarketStatus() async {
    var url = Uri.parse('https://api.wazirx.com/api/v2/market-status');
    var res = await http.get(url);

    return res;
  }
}
