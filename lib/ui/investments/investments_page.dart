import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:investtrack/application_services/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:investtrack/application_services/blocs/investments/investments_bloc.dart';
import 'package:investtrack/application_services/blocs/menu/menu_bloc.dart';
import 'package:investtrack/domain_services/exchange_rate_repository.dart';
import 'package:investtrack/domain_services/investments_repository.dart';
import 'package:investtrack/res/constants/constants.dart' as constants;
import 'package:investtrack/res/constants/hero_tags.dart' as hero_tags;
import 'package:investtrack/router/slide_page_route.dart';
import 'package:investtrack/ui/investments/investment/add_edit_investment_page.dart';
import 'package:investtrack/ui/investments/investment_tile/investment_tile.dart';
import 'package:investtrack/ui/investments/investment_tile/shimmer_investment.dart';
import 'package:investtrack/ui/menu/app_drawer.dart';
import 'package:models/models.dart';

/// The [InvestmentsPage] can access the current user id via
/// `context.select((AuthenticationBloc bloc) => bloc.state.user.id)` and
/// displays it via a [Text] widget. In addition, when the sign out button is
/// tapped, an [AuthenticationLogoutRequested] event is added to the
/// [AuthenticationBloc].
/// `context.select((AuthenticationBloc bloc) => bloc.state.user.id)` will
/// trigger updates if the user id changes.
class InvestmentsPage extends StatefulWidget {
  const InvestmentsPage({super.key});

  static Route<void> route(AuthenticationBloc authenticationBloc) {
    return PageRouteBuilder<void>(
      pageBuilder: (_, __, ___) {
        return BlocProvider<InvestmentsBloc>(
          create: (_) => InvestmentsBloc(
            GetIt.I.get<InvestmentsRepository>(),
            GetIt.I.get<ExchangeRateRepository>(),
            authenticationBloc,
          )..add(const LoadInvestments()),
          child: const InvestmentsPage(),
        );
      },
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        const Offset begin = Offset(1.0, 0.0);
        const Offset end = Offset.zero;
        const Curve curve = Curves.easeInOut;
        final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));
        final Animation<Offset> offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  @override
  State<InvestmentsPage> createState() => _InvestmentsPageState();
}

class _InvestmentsPageState extends State<InvestmentsPage> {
  FeedbackController? _feedbackController;

  @override
  void didChangeDependencies() {
    _feedbackController = BetterFeedback.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            colorScheme.primaryContainer.withOpacity(0.8),
            colorScheme.secondary,
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            children: <Widget>[
              Hero(
                tag: hero_tags.appLogo,
                child: Image.asset(
                  '${constants.imagePath}logo.png',
                  width: 36,
                  height: 36,
                ),
              ),
              const SizedBox(width: 10),
              Text(translate('title')),
            ],
          ),
        ),
        drawer: BlocListener<MenuBloc, MenuState>(
          listener: (_, MenuState state) {
            if (state is FeedbackState) {
              _showFeedbackUi();
            } else if (state is FeedbackSent) {
              _notifyFeedbackSent();
            }
          },
          child: const AppDrawer(),
        ),
        body: BlocConsumer<InvestmentsBloc, InvestmentsState>(
          listener: _handleInvestmentsState,
          builder: (BuildContext context, InvestmentsState state) {
            if (state is InvestmentsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is InvestmentsError) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state.investments.isEmpty) {
              return const Center(
                child: Text(
                  "You don't have any investments yet. "
                  "Why don't you create one?",
                ),
              );
            } else if (state is InvestmentsLoaded) {
              final List<Investment> allInvestments = state.investments;

              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      !state.isLoadingMore &&
                      !state.hasReachedMax) {
                    context
                        .read<InvestmentsBloc>()
                        .add(const LoadMoreInvestments());
                  }
                  return false;
                },
                child: RefreshIndicator(
                  onRefresh: () async {
                    // Trigger event to load investments again.
                    context.read<InvestmentsBloc>().add(
                          const LoadInvestments(),
                        );
                  },
                  child: MediaQuery.sizeOf(context).width > 600
                      ? _buildDesktopTable(allInvestments)
                      : ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: state is CreatingInvestment
                              ? allInvestments.length + 1
                              : allInvestments.length +
                                  // Add extra item for loader.
                                  (state.hasReachedMax ? 0 : 1),
                          itemBuilder: (_, int index) {
                            if (state is CreatingInvestment &&
                                index == allInvestments.length) {
                              return const ShimmerInvestment();
                            } else if (index == allInvestments.length) {
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            final Investment investment = allInvestments[index];
                            return InvestmentTile(investment: investment);
                          },
                        ),
                ),
              );
            } else {
              // TODO: handle this case. We should not be here.
              return const SizedBox();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              SlidePageRoute(
                page: BlocProvider<InvestmentsBloc>.value(
                  value: context.read<InvestmentsBloc>(),
                  child: const AddEditInvestmentPage(),
                ),
              ),
            );
          },
          tooltip: 'Add Investment.',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _feedbackController?.dispose();
    super.dispose();
  }

  void _handleInvestmentsState(BuildContext context, InvestmentsState state) {
    if (state is UnauthenticatedInvestmentsAccessState) {
      context
          .read<AuthenticationBloc>()
          .add(const AuthenticationSignOutPressed());
    } else if (state is InvestmentDeleted) {
      final String message = state.message;
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
      );
    }
  }

  Widget _buildDesktopTable(List<Investment> investments) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(label: Text('Company')),
        DataColumn(label: Text('Stock Exchange')),
        DataColumn(label: Text('Ticker')),
        DataColumn(label: Text('Current Price')),
        DataColumn(label: Text('Currency')),
        DataColumn(label: Text('Price Change')),
        DataColumn(label: Text('% Change')),
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Total Current Value \$')),
        DataColumn(label: Text('Total Value Current CAD')),
        DataColumn(label: Text('Total Value on Purchase Date \$')),
        DataColumn(label: Text('Total Value on Purchase Date CAD')),
        DataColumn(label: Text('Price on Purchase Date')),
        DataColumn(label: Text('Gain or Loss for Stock \$')),
        DataColumn(label: Text('Gain or Loss for Stock in CAD')),
      ],
      rows: investments.map((Investment investment) {
        return DataRow(
          cells: <DataCell>[
            DataCell(Text(investment.companyName)),
            DataCell(Text(investment.stockExchange)),
            DataCell(Text(investment.ticker)),
            const DataCell(
              Text('TODO: dynamically calculate the "currentPrice"'),
            ),
            DataCell(Text(investment.currency)),
            const DataCell(
              Text('TODO: dynamically calculate the "priceChange"'),
            ),
            const DataCell(
              Text('TODO: dynamically calculate the "percentChange"'),
            ),
            DataCell(Text(investment.quantity.toString())),
            DataCell(Text(investment.totalCurrentValue?.toString() ?? 'N/A')),
            const DataCell(
              Text('TODO: dynamically calculate the "totalValueCurrentCAD"'),
            ),
            DataCell(
              Text(investment.totalValueOnPurchase?.toString() ?? 'N/A'),
            ),
            const DataCell(
              Text('TODO: dynamically calculate the "totalValueOnPurchaseCAD"'),
            ),
            DataCell(Text(investment.purchasePrice?.toString() ?? 'N/A')),
            DataCell(Text(investment.gainOrLossUsd?.toString() ?? 'N/A')),
            DataCell(Text(investment.gainOrLossCad?.toString() ?? 'N/A')),
          ],
        );
      }).toList(),
    );
  }

  void _showFeedbackUi() {
    _feedbackController?.show(
      (UserFeedback feedback) =>
          context.read<MenuBloc>().add(SubmitFeedbackEvent(feedback)),
    );
    _feedbackController?.addListener(_onFeedbackChanged);
  }

  void _onFeedbackChanged() {
    final bool? isVisible = _feedbackController?.isVisible;
    if (isVisible == false) {
      _feedbackController?.removeListener(_onFeedbackChanged);
      context.read<MenuBloc>().add(const ClosingFeedbackEvent());
    }
  }

  void _notifyFeedbackSent() {
    BetterFeedback.of(context).hide();
    // Let user know that his feedback is sent.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(translate('feedback.feedbackSent')),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
