import 'dart:convert';

import 'package:dio/dio.dart';
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
  Future<Investment> update(Investment investment) async {
    try {
      final InvestmentResult response = await _restClient.updateInvestment(
        investment,
      );
      return response.investment;
    } catch (error) {
      if (error is DioError) {
        // Try to parse the error message from the response body
        final dynamic responseData = error.response?.data;
        if (responseData is String) {
          // If the response is a raw JSON string, parse it
          final Map<String, dynamic> parsedData = json.decode(responseData);
          throw Exception(parsedData['error'] ?? 'Unknown error occurred');
        } else if (responseData is Map<String, dynamic>) {
          // If the response is already a parsed JSON object
          throw Exception(responseData['error'] ?? 'Unknown error occurred');
        }
      }
      // Re-throw the original error if it's not a DioError or has no response
      // data.
      rethrow;
    }
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
