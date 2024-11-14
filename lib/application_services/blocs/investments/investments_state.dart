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

final class PurchaseValueLoaded extends SelectedInvestmentState {
  const PurchaseValueLoaded({
    required this.purchasePrice,
    required this.currentPrice,
    required super.selectedInvestment,
    super.investments,
  });

  final double purchasePrice;
  final double currentPrice;
}
