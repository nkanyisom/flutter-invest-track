import 'package:investtrack/res/constants/constants.dart' as constants;
import 'package:models/models.dart';

abstract interface class InvestmentsRepository {
  const InvestmentsRepository();

  Future<Investments> getInvestments({
    required String userId,
    int page = constants.pageOffset,
    int investmentsPerPage = constants.itemsPerPage,
  });

  Future<Investment> create(Investment investment);

  Future<Investment> update(Investment investment);

  Future<MessageResponse> delete(Investment investment);

  Future<double> fetchPriceChange(String ticker);

  Future<double> fetchChangePercentage(String ticker);
}
