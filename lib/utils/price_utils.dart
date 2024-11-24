String formatPrice({required double? price, required String currency}) {
  if (price == null) return 'Loading...';
  final String priceValue = price.toStringAsFixed(2);
  return currency == 'USD' ? '\$$priceValue' : '$currency $priceValue';
}