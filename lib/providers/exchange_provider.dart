import 'package:flutter/material.dart';
import 'package:forex_rate/services/exchange_service.dart';
import 'package:intl/intl.dart';

class CurrencyProvider extends ChangeNotifier {
  final ExchangeService _service = ExchangeService();

  String _from = 'USD';
  String _to = 'IDR';
  double _amount = 1.0;
  double? _result;
  String? _lastUpdated;

  String get from => _from;
  String get to => _to;
  double get amount => _amount;
  double? get result => _result;
  String? get lastUpdated => _lastUpdated;

  void setFrom(String? value) {
    if (value != null) {
      _from = value;
      notifyListeners();
    }
  }

  void setTo(String? value) {
    if (value != null) {
      _to = value;
      notifyListeners();
    }
  }

  void setAmount(String value) {
    final parsed = double.tryParse(value);
    if (parsed != null) {
      _amount = parsed;
      notifyListeners();
    }
  }

  void swapCurrencies() {
    final temp = _from;
    _from = _to;
    _to = temp;
    notifyListeners();
  }

  Future<void> convert() async {
    if (_from == _to) {
      _result = _amount;
      _lastUpdated = _formattedNow();
      notifyListeners();
      return;
    }

    final rate = await _service.getExchangeRate(_from, _to);
    if (rate != null) {
      _result = _amount * rate;
      _lastUpdated = _formattedNow();
      notifyListeners();
    } else {
      _result = null;
      _lastUpdated = null;
      notifyListeners();
    }
  }

  String _formattedNow() {
    return DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  }
}
