import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/exchange_screen.dart';
import 'providers/exchange_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CurrencyProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      home: HomeScreen(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
