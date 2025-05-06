import 'dart:convert';
import 'package:http/http.dart' as http;

class ExchangeService {
  final String apiKey = 'aeafff23c14a4e0bb6d677309f126d89';

  Future<double?> getExchangeRate(String from, String to) async {
    final url = Uri.parse(
      'https://api.currencyfreaks.com/v2.0/rates/latest?apikey=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rates = data['rates'];

      if (rates != null && rates[to] != null && rates[from] != null) {
        double toRate = double.parse(rates[to]);
        double fromRate = double.parse(rates[from]);

        return toRate / fromRate;
      } else {
        print('Invalid currency code');
      }
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
    return null;
  }
}
