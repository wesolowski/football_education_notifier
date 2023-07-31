import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

abstract interface class RequestInterface {
  Future<List<dynamic>> fetchData(String url);
}

class Request implements RequestInterface {
  @override
  Future<List<dynamic>> fetchData(String url) async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as List<dynamic>;
    }

    throw Exception('Error on URL: ${response.statusCode}');
  }
}


