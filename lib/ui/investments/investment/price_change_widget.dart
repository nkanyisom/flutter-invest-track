import 'package:flutter/material.dart';

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
        _buildInfoRow(
          context,
          'Price Change',
          '${priceChange.toStringAsFixed(2)}\$',
          priceChange >= 0 ? Icons.trending_up : Icons.trending_down,
          priceChange >= 0 ? Colors.green : Colors.red,
        ),
        _buildInfoRow(
          context,
          'Change %',
          '${changePercentage.toStringAsFixed(2)}%',
          changePercentage >= 0 ? Icons.trending_up : Icons.trending_down,
          changePercentage >= 0 ? Colors.green : Colors.red,
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, [
    Color? valueColor,
  ]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                color: valueColor ?? Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: valueColor ?? Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}
