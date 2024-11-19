import 'package:models/src/abstract/rates.dart';

abstract interface class ExchangeRate {
  const ExchangeRate({
    required this.rates,
    this.provider,
    this.warningUpgradeToV6,
    this.terms,
    this.base,
    this.date,
    this.timeLastUpdated,
  });

  final String? provider;
  final String? warningUpgradeToV6;
  final String? terms;
  final String? base;
  final String? date;
  final int? timeLastUpdated;
  final Rates rates;
}
