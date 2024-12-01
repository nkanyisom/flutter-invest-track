String formatPrice({required double? price, String currency = 'USD'}) {
  if (price == null || price == 0) return 'Loading...';
  final String priceValue = price.toStringAsFixed(2);
  return currency == 'USD' ? '\$$priceValue' : '$currency $priceValue';
}
