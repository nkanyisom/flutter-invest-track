part of 'investments_bloc.dart';

@immutable
sealed class InvestmentsState {
  const InvestmentsState({this.investments = const <Investment>[]});

  final List<Investment> investments;
}

final class InvestmentsInitial extends InvestmentsState {
  const InvestmentsInitial();
}

final class CreatingInvestment extends InvestmentsState {
  const CreatingInvestment({super.investments});
}

abstract class SubmittingInvestment extends InvestmentsState {
  const SubmittingInvestment({
    required this.investmentId,
    required super.investments,
  });

  final int investmentId;
}

final class UpdatingInvestment extends SubmittingInvestment {
  const UpdatingInvestment({
    required super.investmentId,
    required super.investments,
  });
}

final class InvestmentDeleting extends SubmittingInvestment {
  const InvestmentDeleting({
    required super.investmentId,
    required super.investments,
  });
}

final class InvestmentSubmitted extends InvestmentsState {
  const InvestmentSubmitted({super.investments});
}

final class InvestmentDeleted extends InvestmentsState {
  const InvestmentDeleted({required this.message, super.investments});

  final String message;
}

final class InvestmentsError extends InvestmentsState {
  const InvestmentsError({required this.error, super.investments});

  final String error;
}

final class UnauthenticatedInvestmentsAccessState extends InvestmentsError {
  const UnauthenticatedInvestmentsAccessState({required super.error});
}

final class InvestmentsLoaded extends InvestmentsState {
  const InvestmentsLoaded({super.investments});
}

final class SelectedInvestmentState extends InvestmentsState {
  const SelectedInvestmentState({
    required this.selectedInvestment,
    super.investments,
  });

  final Investment selectedInvestment;
}

final class ValueLoadingState extends SelectedInvestmentState {
  const ValueLoadingState({
    required super.selectedInvestment,
    super.investments,
  });
}

final class CurrentValueLoaded extends ValueLoadingState {
  const CurrentValueLoaded({
    required this.currentPrice,
    required super.selectedInvestment,
    super.investments,
  });

  final double currentPrice;
}

final class ExchangeRateLoaded extends CurrentValueLoaded {
  const ExchangeRateLoaded({
    required this.exchangeRate,
    required super.currentPrice,
    required super.selectedInvestment,
    super.investments,
  });

  final double exchangeRate;
}

final class InvestmentUpdated extends SelectedInvestmentState {
  const InvestmentUpdated({
    required this.purchasePrice,
    required this.currentPrice,
    required super.selectedInvestment,
    required this.exchangeRate,
    required super.investments,
    this.priceChange = 0,
    this.changePercentage = 0,
  });

  final double purchasePrice;
  final double currentPrice;
  final double exchangeRate;
  final double priceChange;
  final double changePercentage;

  InvestmentUpdated copyWith({
    double? purchasePrice,
    double? currentPrice,
    double? exchangeRate,
    double? priceChange,
    double? changePercentage,
    Investment? selectedInvestment,
    List<Investment>? investments,
  }) {
    return InvestmentUpdated(
      purchasePrice: purchasePrice ?? this.purchasePrice,
      currentPrice: currentPrice ?? this.currentPrice,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      priceChange: priceChange ?? this.priceChange,
      changePercentage: changePercentage ?? this.changePercentage,
      selectedInvestment: selectedInvestment ?? this.selectedInvestment,
      investments: investments ?? this.investments,
    );
  }
}
