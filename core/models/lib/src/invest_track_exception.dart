class InvestTrackException implements Exception {
  const InvestTrackException(this.message);

  final String message;

  @override
  String toString() {
    return 'InvestTrackException: $message';
  }
}
