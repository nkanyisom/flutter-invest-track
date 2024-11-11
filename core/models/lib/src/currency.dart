class Currency {
  const Currency({
    required this.entity,
    required this.currency,
    required this.alphabeticCode,
    required this.numericCode,
    this.minorUnit = 0,
    this.withdrawalDate,
  });

  final String entity;
  final String currency;
  final String alphabeticCode;
  final int numericCode;
  final int minorUnit;
  final String? withdrawalDate;
}
