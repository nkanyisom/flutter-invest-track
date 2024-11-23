import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investtrack/application_services/blocs/investments/investments_bloc.dart';
import 'package:investtrack/router/slide_page_route.dart';
import 'package:investtrack/ui/investments/investment/investment_page.dart';
import 'package:investtrack/ui/investments/investment_tile/investment_detail.dart';
import 'package:models/models.dart';

class InvestmentCard extends StatelessWidget {
  const InvestmentCard({
    required this.investment,
    super.key,
  });

  final Investment investment;

  @override
  Widget build(BuildContext context) {
    final String purchaseDateTimestamp =
        investment.purchaseDate?.toLocal().toString().split(' ').firstOrNull ??
            '';
    final int quantity = investment.quantity;
    return Card(
      elevation: 6.0,
      margin: const EdgeInsets.all(8.0),
      shadowColor: Colors.blueGrey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade700, width: 0.5),
      ),
      color: Theme.of(context).colorScheme.surface.withOpacity(0.6),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: () => _navigateToInvestmentDetails(context),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      investment.companyLogoUrl,
                    ),
                    radius: 24,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          investment.ticker,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          investment.companyName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              if (quantity > 0)
                InvestmentDetail(
                  label: 'Quantity',
                  value: quantity.toString(),
                  icon: Icons.pie_chart,
                ),
              InvestmentDetail(
                label: 'Current Price',
                value: investment.currency == 'USD'
                    ? '\$${investment.currentPrice?.toStringAsFixed(2) ?? ''
                        'Loading...'}'
                    : '${investment.currency} '
                        '${investment.currentPrice?.toStringAsFixed(2) ?? ''
                            'Loading...'}',
                icon: Icons.monetization_on,
              ),
              if (quantity > 0)
                InvestmentDetail(
                  label: 'Gain/Loss (USD)',
                  value: investment.gainOrLossUsd?.toString() ?? 'N/A',
                  icon: Icons.trending_up,
                ),
              if (quantity > 0)
                InvestmentDetail(
                  label: 'Gain/Loss (CAD)',
                  value: investment.gainOrLossCad?.toString() ?? 'N/A',
                  icon: Icons.trending_down,
                ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      purchaseDateTimestamp.isEmpty
                          ? 'Not yet purchased.'
                          : 'Purchased: $purchaseDateTimestamp',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.watch_later_outlined,
                      size: 16,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToInvestmentDetails(BuildContext context) {
    Navigator.of(context).push(
      SlidePageRoute(
        page: BlocProvider<InvestmentsBloc>.value(
          value: context.read<InvestmentsBloc>()
            ..add(LoadInvestment(investment)),
          child: const InvestmentPage(),
        ),
      ),
    );
  }
}
