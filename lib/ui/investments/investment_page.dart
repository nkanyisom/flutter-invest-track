import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:yahoo_finance_data_reader/yahoo_finance_data_reader.dart';

//TODO: clean up this mess.
class InvestmentPage extends StatefulWidget {
  const InvestmentPage({required this.investment, super.key});

  final Investment investment;

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  double _currentPrice = 0.0;
  double _purchasePrice = 0.0;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fetchStockData();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _fetchStockData() async {
    try {
      final YahooFinanceResponse currentValue =
          await const YahooFinanceDailyReader().getDailyDTOs(
        widget.investment.ticker,
        startDate: DateTime.now(),
      );
      setState(() {
        _currentPrice = currentValue.candlesData.firstOrNull?.close ?? 0;
      });
      final YahooFinanceResponse purchaseValue =
          await const YahooFinanceDailyReader().getDailyDTOs(
        widget.investment.ticker,
        startDate: widget.investment.purchaseDate,
      );
      setState(() {
        _purchasePrice = purchaseValue.candlesData.firstOrNull?.close ?? 0;
        _isLoading = false;
      });
      _animationController.forward();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Failed to fetch stock data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final int quantity = widget.investment.quantity;
    final double totalValueCurrent = quantity * _currentPrice;
    final double totalValuePurchase = quantity * _purchasePrice;
    final double gainOrLoss = totalValueCurrent - totalValuePurchase;
    final double gainOrLossPercentage =
        totalValuePurchase != 0 ? (gainOrLoss / totalValuePurchase) * 100 : 0;
    final String currency = widget.investment.currency;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.investment.ticker,     style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),),
        actions: <Widget>[
          if (_isLoading) const CircularProgressIndicator(),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (widget.investment.companyLogoUrl.isNotEmpty)
                    ColoredBox(
                      color: Colors.white,
                      child: Image.network(
                        widget.investment.companyLogoUrl,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.investment.companyName),
                      Text(widget.investment.type),
                      Text(widget.investment.stockExchange),
                      Text(currency),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInfoRow(
                context,
                'Current Price',
                _currentPrice.toStringAsFixed(2),
                Icons.monetization_on,
              ),
              _buildInfoRow(
                context,
                'Quantity',
                widget.investment.quantity.toString(),
                Icons.confirmation_number,
              ),
              _buildInfoRow(
                context,
                'Total Value (Current)',
                totalValueCurrent.toStringAsFixed(2),
                Icons.attach_money,
              ),
              _buildInfoRow(
                context,
                'Purchase Date',
                widget.investment.purchaseDate
                        ?.toIso8601String()
                        .split('T')
                        .firstOrNull ??
                    '',
                Icons.calendar_today,
              ),
              _buildInfoRow(
                context,
                'Purchase Price',
                _purchasePrice.toStringAsFixed(2),
                Icons.price_check,
              ),
              _buildInfoRow(
                context,
                'Total Value (Purchase)',
                totalValuePurchase.toStringAsFixed(2),
                Icons.money,
              ),
              _buildInfoRow(
                context,
                'Gain/Loss',
                '${gainOrLoss.toStringAsFixed(2)} '
                    '(${gainOrLossPercentage.toStringAsFixed(2)}%)',
                gainOrLoss >= 0 ? Icons.trending_up : Icons.trending_down,
                gainOrLoss >= 0 ? Colors.green : Colors.red,
              ),
            ],
          ),
        ),
      ),
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
