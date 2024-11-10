import 'package:authentication_repository/authentication_repository.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get_it/get_it.dart';
import 'package:investtrack/application_services/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:investtrack/di/injector.dart';
import 'package:investtrack/localization/localization_delelegate_getter.dart'
    as localization;
import 'package:investtrack/ui/app/app.dart';
import 'package:investtrack/ui/feedback/feedback_form.dart';
import 'package:yahoo_finance_data_reader/yahoo_finance_data_reader.dart';

/// The [main] is the ultimate detail — the lowest-level policy.
/// It is the initial entry point of the system.
/// Nothing, other than the operating system, depends on it.
/// Here we should [injectDependencies] by a dependency injection framework.
/// The [main] is a dirty low-level module in the outermost circle of the onion
/// architecture.
/// Think of [main] as a plugin to the [App] — a plugin that sets
/// up the initial conditions and configurations, gathers all the outside
/// resources, and then hands control over to the high-level policy of the
/// [App].
/// When [main] is released, it has utterly no effect on any of the other
/// components in the system. They don’t know about [main], and they don’t care
/// when it changes.
Future<void> main() async {
  // Ensure that the Flutter engine is initialized, to avoid errors with
  // `SharedPreferences` dependencies initialization.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection and wait for `SharedPreferences`.
  await injectDependencies();

  final LocalizationDelegate localizationDelegate =
      await localization.getLocalizationDelegate();

  final AuthenticationRepository authenticationRepository =
      GetIt.instance<AuthenticationRepository>();
  final AuthenticationBloc authenticationBloc =
      GetIt.instance<AuthenticationBloc>();

  runApp(
    LocalizedApp(
      localizationDelegate,
      BetterFeedback(
        feedbackBuilder: (
          BuildContext context,
          OnSubmit onSubmit,
          ScrollController? scrollController,
        ) =>
            FeedbackForm(
          onSubmit: onSubmit,
          scrollController: scrollController,
        ),
        child: App(
          authenticationRepository: authenticationRepository,
          authenticationBloc: authenticationBloc,
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'yahoo_finance_data_reader 1.0.11 Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _ticker = 'GOOG';
  YahooFinanceResponse? _response;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchStockData();
  }

  Future<void> _fetchStockData() async {
    try {
      final DateTime now = DateTime.now();
      final YahooFinanceResponse response =
          await const YahooFinanceDailyReader().getDailyDTOs(
        _ticker,
        startDate: DateTime(now.year, now.month, now.day),
      );
      setState(() {
        _response = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      debugPrint('Failed to fetch stock data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('yahoo_finance_data_reader 1.0.11 demo'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _response == null || _response!.candlesData.isEmpty
                ? const Text('Failed to load stock data')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Stock Data for $_ticker:',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Open: ${_response!.candlesData.first.open}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'Close: ${_response!.candlesData.first.close}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'High: ${_response!.candlesData.first.high}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'Low: ${_response!.candlesData.first.low}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
      ),
    );
  }
}
