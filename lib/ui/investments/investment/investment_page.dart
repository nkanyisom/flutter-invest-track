import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investtrack/application_services/blocs/investments/investments_bloc.dart';
import 'package:investtrack/router/app_route.dart';
import 'package:investtrack/router/slide_page_route.dart';
import 'package:investtrack/ui/investments/investment/add_edit_investment_page.dart';
import 'package:investtrack/ui/investments/investment/price_change_widget.dart';
import 'package:models/models.dart';

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({super.key});

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvestmentsBloc, InvestmentsState>(
      listener: (BuildContext context, InvestmentsState state) {
        if (state is InvestmentDeleted) {
          Navigator.pushReplacementNamed(
            context,
            AppRoute.investments.name,
          );
        }
      },
      builder: (BuildContext context, InvestmentsState state) {
        if (state is SelectedInvestmentState) {
          final Investment investment = state.selectedInvestment;
          final int quantity = investment.quantity;
          double totalValueCurrent = 0;

          double currentPrice = 0;
          if (state is CurrentValueLoaded) {
            currentPrice = state.currentPrice;
          }

          double exchangeRate = 1;
          if (state is ExchangeRateLoaded) {
            exchangeRate = state.exchangeRate;
          }

          double totalValuePurchase = 0;
          if (state is InvestmentUpdated) {
            totalValuePurchase = quantity * state.purchasePrice;
            currentPrice = state.currentPrice;
            totalValueCurrent = quantity * state.currentPrice;
            exchangeRate = state.exchangeRate;
          }

          final double totalValueCad = totalValueCurrent * exchangeRate;
          final double totalValuePurchaseCad =
              totalValuePurchase * exchangeRate;
          final double gainOrLoss = totalValueCurrent - totalValuePurchase;
          final double gainOrLossCad = totalValueCad - totalValuePurchaseCad;
          final double gainOrLossPercentage = totalValuePurchase != 0
              ? (gainOrLoss / totalValuePurchase) * 100
              : 0;

          final double gainOrLossPercentageCad = totalValuePurchaseCad != 0
              ? ((gainOrLossCad / totalValuePurchaseCad) * 100) * 100
              : 0;
          final String currency = investment.currency;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                investment.ticker,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: <Widget>[
                if (state is ValueLoadingState)
                  const CircularProgressIndicator(),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editInvestment(investment),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: state is InvestmentDeleting
                      ? null
                      : () => _deleteInvestment(investment),
                ),
              ],
            ),
            body: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          if (investment.companyLogoUrl.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              // Adjust the radius as needed
                              child: ColoredBox(
                                color: Colors.white,
                                child: Image.network(
                                  investment.companyLogoUrl,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(investment.companyName),
                              Text(investment.type),
                              Text(investment.stockExchange),
                              Text(currency),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (state is ValueLoadingState)
                        const CircularProgressIndicator()
                      else
                        _buildInfoRow(
                          context,
                          'Current Price',
                          currentPrice.toStringAsFixed(2),
                          Icons.monetization_on,
                        ),
                      _buildInfoRow(
                        context,
                        'Quantity',
                        investment.quantity.toString(),
                        Icons.confirmation_number,
                      ),
                      if (state is ValueLoadingState)
                        const CircularProgressIndicator()
                      else
                        _buildInfoRow(
                          context,
                          'Total Value (Current)',
                          totalValueCurrent.toStringAsFixed(2),
                          Icons.attach_money,
                        ),
                      if (state is ValueLoadingState)
                        const CircularProgressIndicator()
                      else
                        _buildInfoRow(
                          context,
                          'Total Value (Current CAD)',
                          totalValueCad.toStringAsFixed(2),
                          Icons.currency_exchange_sharp,
                        ),
                      _buildInfoRow(
                        context,
                        'Purchase Date',
                        investment.purchaseDate
                                ?.toIso8601String()
                                .split('T')
                                .firstOrNull ??
                            '',
                        Icons.calendar_today,
                      ),
                      if (state is InvestmentUpdated)
                        _buildInfoRow(
                          context,
                          'Purchase Price',
                          state.purchasePrice.toStringAsFixed(2),
                          Icons.price_check,
                        )
                      else
                        const CircularProgressIndicator(),
                      _buildInfoRow(
                        context,
                        'Total Value (Purchase)',
                        totalValuePurchase.toStringAsFixed(2),
                        Icons.money,
                      ),
                      _buildInfoRow(
                        context,
                        'Total Value (Purchase CAD)',
                        totalValuePurchaseCad.toStringAsFixed(2),
                        Icons.money_rounded,
                      ),
                      if (state is InvestmentUpdated)
                        _buildInfoRow(
                          context,
                          'Gain/Loss',
                          '${gainOrLoss.toStringAsFixed(2)} '
                              '(${gainOrLossPercentage.toStringAsFixed(2)}%)',
                          gainOrLoss >= 0
                              ? Icons.trending_up
                              : Icons.trending_down,
                          gainOrLoss >= 0 ? Colors.green : Colors.red,
                        )
                      else
                        const CircularProgressIndicator(),
                      if (state is InvestmentUpdated)
                        _buildInfoRow(
                          context,
                          'Gain/Loss CAD',
                          '${gainOrLossCad.toStringAsFixed(2)} '
                              '(${gainOrLossPercentageCad.toStringAsFixed(2)}'
                              '%)',
                          gainOrLossCad >= 0
                              ? Icons.trending_up
                              : Icons.trending_down,
                          gainOrLossCad >= 0 ? Colors.green : Colors.red,
                        )
                      else
                        const CircularProgressIndicator(),
                      if (state is InvestmentUpdated)
                        PriceChangeWidget(
                          priceChange: state.priceChange,
                          changePercentage: state.changePercentage,
                        )
                      else
                        const CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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

  void _editInvestment(Investment investment) {
    Navigator.of(context).push(
      SlidePageRoute(
        page: BlocProvider<InvestmentsBloc>.value(
          value: context.read<InvestmentsBloc>(),
          child: AddEditInvestmentPage(investment: investment),
        ),
      ),
    );
  }

  void _deleteInvestment(Investment investment) {
    context.read<InvestmentsBloc>().add(DeleteInvestmentEvent(investment));
  }
}
