import 'package:models/models.dart';

abstract interface class InvestmentsRepository {
  const InvestmentsRepository();

  Future<List<Investment>> getInvestments({required String userId, int? page});

  Future<Investment> create(Investment investment);

  Future<Investment> update(Investment investment);

  Future<MessageResponse> delete(Investment investment);

  Future<double> fetchPriceChange(String ticker);

  Future<double> fetchChangePercentage(String ticker);
}
