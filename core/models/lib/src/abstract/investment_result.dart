import 'package:models/models.dart';

abstract interface class InvestmentResult {
  const InvestmentResult(this.investment);

  final Investment investment;
}
