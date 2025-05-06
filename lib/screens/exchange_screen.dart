import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:forex_rate/providers/exchange_provider.dart';

class HomeScreen extends StatelessWidget {
  final List<String> currencies = [
    'USD', 'IDR', 'EUR', 'GBP', 'JPY', 'AUD', 'SGD', 'CNY'
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CurrencyProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Currency Converter')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Dropdown Row (From - Swap - To)
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: provider.from,
                      onChanged: provider.setFrom,
                      items: currencies.map((currency) {
                        return DropdownMenuItem(
                            value: currency, child: Text(currency));
                      }).toList(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.swap_horiz),
                    onPressed: provider.swapCurrencies,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: provider.to,
                      onChanged: provider.setTo,
                      items: currencies.map((currency) {
                        return DropdownMenuItem(
                            value: currency, child: Text(currency));
                      }).toList(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Input Field
              TextField(
                decoration: const InputDecoration(labelText: 'Jumlah'),
                keyboardType: TextInputType.number,
                onChanged: provider.setAmount,
              ),

              const SizedBox(height: 20),

              // Convert Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: provider.convert,
                  child: const Text('Convert'),
                ),
              ),

              const SizedBox(height: 20),

              // Result Text
              if (provider.result != null)
                Text(
                  '${provider.amount} ${provider.from} = ${provider.result!.toStringAsFixed(2)} ${provider.to}',
                  style: const TextStyle(fontSize: 18),
                ),

              const SizedBox(height: 40),

              // Footer
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Last updated: ${provider.lastUpdated ?? "N/A"}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
