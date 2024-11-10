import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investtrack/application_services/blocs/investments/investments_bloc.dart';
import 'package:investtrack/ui/investments/add_edit_investment_dialog.dart';
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
        investment.purchaseDate?.toLocal().toString().split(' ').first ?? 'N/A';

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      shadowColor: Colors.white24,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: () => showDialog(
          context: context,
          builder: (_) => BlocProvider<InvestmentsBloc>.value(
            value: context.read<InvestmentsBloc>(),
            child: AddEditInvestmentDialog(investment: investment),
          ),
        ),
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
                      investment.companyLogoUrl ?? '',
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
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              _buildInvestmentDetail(
                context,
                label: 'Stock Exchange',
                value: investment.stockExchange,
                icon: Icons.business,
              ),
              _buildInvestmentDetail(
                context,
                label: 'Quantity',
                value: investment.quantity.toString(),
                icon: Icons.pie_chart,
              ),
              _buildInvestmentDetail(
                context,
                label: 'Current Value',
                value: investment.totalCurrentValue?.toString() ?? 'N/A',
                icon: Icons.monetization_on,
              ),
              _buildInvestmentDetail(
                context,
                label: 'Gain/Loss (USD)',
                value: investment.gainOrLossUsd?.toString() ?? 'N/A',
                icon: Icons.trending_up,
              ),
              _buildInvestmentDetail(
                context,
                label: 'Gain/Loss (CAD)',
                value: investment.gainOrLossCad?.toString() ?? 'N/A',
                icon: Icons.trending_down,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Purchased: $purchaseDateTimestamp',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInvestmentDetail(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, size: 16, color: Colors.teal),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
