import 'package:flutter/material.dart';
import 'package:investtrack/ui/investments/investment/info_row.dart';

class PriceChangeWidget extends StatelessWidget {
  const PriceChangeWidget({
    required this.priceChange,
    required this.changePercentage,
    super.key,
  });

  final double priceChange;
  final double changePercentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InfoRow(
          label: 'Price Change',
          value: '\$${priceChange.toStringAsFixed(2)}',
          icon: priceChange >= 0 ? Icons.trending_up : Icons.trending_down,
          valueColor: priceChange >= 0 ? Colors.green : Colors.red,
        ),
        InfoRow(
          label: 'Change %',
          value: '${changePercentage.toStringAsFixed(2)}%',
          icon: changePercentage >= 0 ? Icons.trending_up : Icons.trending_down,
          valueColor: changePercentage >= 0 ? Colors.green : Colors.red,
        ),
      ],
    );
  }
}
