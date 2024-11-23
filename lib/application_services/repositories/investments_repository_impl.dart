import 'package:injectable/injectable.dart';
import 'package:investtrack/domain_services/investments_repository.dart';
import 'package:investtrack/res/constants/constants.dart' as constants;
import 'package:models/models.dart';

@Injectable(as: InvestmentsRepository)
class InvestmentsRepositoryImpl implements InvestmentsRepository {
  const InvestmentsRepositoryImpl(this._restClient);

  final RestClient _restClient;

  @override
  Future<Investments> getInvestments({
    required String userId,
    int page = constants.pageOffset,
    int investmentsPerPage = constants.itemsPerPage,
  }) {
    return _restClient.getInvestments(userId, page, investmentsPerPage);
  }

  @override
  Future<Investment> create(Investment investment) {
    return _restClient
        .createInvestment(investment)
        .then((InvestmentResult response) {
      return response.investment;
    });
  }

  @override
  Future<MessageResponse> delete(Investment investment) =>
      _restClient.deleteInvestment(investment.id);

  @override
  Future<Investment> update(Investment investment) {
    // TODO: handle error.
    return _restClient
        .updateInvestment(investment)
        .then((InvestmentResult response) {
      return response.investment;
    });
  }

  @override
  Future<double> fetchPriceChange(String ticker) {
    return _restClient.fetchPriceChange(ticker).then(
          (PriceChange response) => response.priceChange,
        );
  }

  @override
  Future<double> fetchChangePercentage(String ticker) {
    return _restClient.fetchChangePercentage(ticker).then(
          (ChangePercentage response) => response.changePercentage,
        );
  }
}
