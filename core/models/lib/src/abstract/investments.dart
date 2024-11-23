import 'package:models/models.dart';

abstract interface class Investments {
  const Investments({
    required this.investments,
    required this.totalPages,
    required this.currentPage,
  });

  final List<Investment> investments;
  final int totalPages;
  final int currentPage;
}
