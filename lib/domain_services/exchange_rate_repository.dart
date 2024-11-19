abstract interface class ExchangeRateRepository {
  const ExchangeRateRepository();

  Future<double> getExchangeRate({
    required String fromCurrency,
    String toCurrency,
  });
}
