import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:investtrack/application_services/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:investtrack/domain_services/exchange_rate_repository.dart';
import 'package:investtrack/domain_services/investments_repository.dart';
import 'package:investtrack/res/constants/constants.dart' as constants;
import 'package:models/models.dart';
import 'package:yahoo_finance_data_reader/yahoo_finance_data_reader.dart';

part 'investments_event.dart';
part 'investments_state.dart';

class InvestmentsBloc extends Bloc<InvestmentsEvent, InvestmentsState> {
  InvestmentsBloc(
    this._investmentsRepository,
    this._exchangeRateRepository,
    this._authenticationBloc,
  ) : super(const InvestmentsLoading()) {
    on<LoadInvestments>(_loadInvestments);
    on<LoadMoreInvestments>(_loadMoreInvestments);
    on<CreateInvestmentEvent>((
      CreateInvestmentEvent event,
      Emitter<InvestmentsState> emit,
    ) async {
      await _handleCreateOrUpdateInvestment(emitter: emit, event: event);
    });
    on<UpdateInvestmentEvent>((
      UpdateInvestmentEvent event,
      Emitter<InvestmentsState> emit,
    ) async {
      await _handleCreateOrUpdateInvestment(emitter: emit, event: event);
    });

    on<DeleteInvestmentEvent>(_deleteInvestment);
    on<LoadInvestment>(_loadInvestment);
  }

  FutureOr<void> _loadInvestment(
    LoadInvestment event,
    Emitter<InvestmentsState> emit,
  ) async {
    final Investment investment = event.investment;
    if (state is InvestmentsLoaded) {
      emit(
        SelectedInvestmentState(
          selectedInvestment: investment,
          investments: state.investments,
        ),
      );

      emit(
        ValueLoadingState(
          selectedInvestment: investment,
          investments: state.investments,
        ),
      );
    }

    final String ticker = investment.ticker;

    final YahooFinanceResponse currentValue =
        await const YahooFinanceDailyReader().getDailyDTOs(
      ticker,
    );

    final double currentPrice = currentValue.candlesData.lastOrNull?.close ?? 0;

    if (currentPrice != 0 && state is InvestmentsLoaded) {
      emit(
        CurrentValueLoaded(
          currentPrice: currentPrice,
          selectedInvestment: investment,
          investments: state.investments,
        ),
      );
    }

    final String currency = investment.currency;

    final double cadExchangeRate = currency == 'CAD'
        ? 1
        : await _exchangeRateRepository.getExchangeRate(
            fromCurrency: investment.currency,
            toCurrency: 'CAD',
          );
    if (state is InvestmentsLoaded) {
      emit(
        ExchangeRateLoaded(
          currentPrice: currentPrice,
          selectedInvestment: investment,
          investments: state.investments,
          exchangeRate: cadExchangeRate,
        ),
      );
    }

    final YahooFinanceResponse purchaseValue =
        await const YahooFinanceDailyReader().getDailyDTOs(
      ticker,
      startDate: investment.purchaseDate,
    );
    final double purchasePrice =
        purchaseValue.candlesData.firstOrNull?.close ?? 0;

    if (purchasePrice != 0 && currentPrice != 0 && state is InvestmentsLoaded) {
      emit(
        InvestmentUpdated(
          purchasePrice: purchasePrice,
          selectedInvestment: investment,
          investments: state.investments,
          currentPrice: currentPrice,
          exchangeRate: cadExchangeRate,
        ),
      );
    }

    final double priceChange = await _investmentsRepository.fetchPriceChange(
      ticker,
    );

    if (state is InvestmentUpdated) {
      emit(
        (state as InvestmentUpdated).copyWith(priceChange: priceChange),
      );
    }
    final double changePercentage =
        await _investmentsRepository.fetchChangePercentage(
      ticker,
    );
    if (state is InvestmentUpdated) {
      emit(
        (state as InvestmentUpdated).copyWith(
          changePercentage: changePercentage,
        ),
      );
    }
  }

  FutureOr<void> _deleteInvestment(
    DeleteInvestmentEvent event,
    Emitter<InvestmentsState> emit,
  ) async {
    final Investment investment = event.investment;

    if (state is InvestmentsLoaded) {
      emit(
        InvestmentDeleting(
          investmentId: investment.id,
          investments: state.investments,
        ),
      );
    }

    // Get the user ID from the authentication bloc.
    final String userId = _authenticationBloc.state.user.id;

    if (userId.isEmpty) {
      emit(
        const UnauthenticatedInvestmentsAccessState(
          error: 'User ID not found.',
        ),
      );
      return;
    }

    final MessageResponse response = await _investmentsRepository
        .delete(investment.copyWith(userId: userId));
    // Remove the investment from the existing list of investments.
    final List<Investment> updatedInvestments =
        List<Investment>.from(state.investments)..remove(investment);

    if (state is InvestmentsLoaded) {
      // Emit the new state with the updated list of investments.
      emit(
        InvestmentDeleted(
          message: response.message,
          investments: updatedInvestments,
        ),
      );
    }
  }

  FutureOr<void> _loadInvestments(
    LoadInvestments event,
    Emitter<InvestmentsState> emit,
  ) async {
    emit(const InvestmentsLoading());
    // Access the user ID from the AuthenticationBloc's state.
    final String userId = _authenticationBloc.state.user.id;

    if (userId.isEmpty) {
      emit(
        const UnauthenticatedInvestmentsAccessState(
          error: 'User ID not found.',
        ),
      );
      return;
    }

    try {
      // Fetch the first batch of investments using the user ID.
      final Investments investments =
          await _investmentsRepository.getInvestments(
        userId: userId,
      );

      final List<Investment> investmentBatch = investments.investments;
      final int currentPage = investments.currentPage;
      final int totalPages = investments.totalPages;
      final bool hasReachedMax = currentPage >= totalPages;
      emit(
        InvestmentsLoaded(
          investments: investmentBatch,
          hasReachedMax: hasReachedMax,
        ),
      );
      // Fetch current prices asynchronously.
      final List<Investment> updatedInvestments = await Future.wait(
        investmentBatch.map((Investment investment) async {
          final YahooFinanceResponse response =
              await const YahooFinanceDailyReader().getDailyDTOs(
            investment.ticker,
          );
          final double currentPrice =
              response.candlesData.lastOrNull?.close ?? 0;

          return investment.copyWith(currentPrice: currentPrice);
        }).toList(),
      );
      // Emit updated investments with current prices.
      emit(
        InvestmentsUpdated(
          investments: updatedInvestments,
          hasReachedMax: hasReachedMax,
        ),
      );
    } catch (error, stackTrace) {
      debugPrint('Stacktrace for an error in $runtimeType: $stackTrace.');
      emit(InvestmentsError(error: error.toString()));
    }
  }

  Future<void> _handleCreateOrUpdateInvestment({
    required Emitter<InvestmentsState> emitter,
    required InvestmentsEvent event,
  }) async {
    final List<Investment> investments = List<Investment>.from(
      state.investments,
    );
    if (event is CreateInvestmentEvent) {
      if (state is InvestmentsLoaded) {
        emitter(CreatingInvestment(investments: state.investments));
      }

      // Get the user ID from the authentication bloc.
      final String userId = _authenticationBloc.state.user.id;
      final Investment createdInvestment = event.investment;
      // Create the new createdInvestment using the repository.
      final Investment newInvestment = await _investmentsRepository.create(
        Investment.create(
          ticker: createdInvestment.ticker,
          type: createdInvestment.type,
          companyName: createdInvestment.companyName,
          stockExchange: createdInvestment.stockExchange,
          currency: createdInvestment.currency,
          description: createdInvestment.description,
          quantity: createdInvestment.quantity,
          companyLogoUrl: createdInvestment.companyLogoUrl,
          purchaseDate: createdInvestment.purchaseDate,
          userId: userId,
        ),
      );

      // Add the new createdInvestment to the existing list of investments.
      investments.add(newInvestment);
    } else if (event is UpdateInvestmentEvent) {
      final Investment investment = event.investment;
      if (state is InvestmentsLoaded) {
        emitter(
          UpdatingInvestment(
            investmentId: investment.id,
            investments: state.investments,
          ),
        );
      }

      try {
        final Investment updatedInvestment =
            await _investmentsRepository.update(investment);

        // Update the createdInvestment in the existing list of investments.
        final int index = investments.indexWhere(
          (Investment existingInvestment) =>
              existingInvestment.id == updatedInvestment.id,
        );
        if (index != -1) {
          investments[index] = updatedInvestment;
        }
      } catch (error, stackTrace) {
        debugPrint(
          'Error in $runtimeType: ${error.runtimeType}, $error,\n'
          'stack trace: $stackTrace',
        );
        emitter(
          InvestmentsError(
            investments: investments,
            error: '$error',
          ),
        );
      }
    }

    if (state is InvestmentsLoaded) {
      // Emit the new state with the updated list of investments.
      emitter(
        InvestmentSubmitted(investments: investments),
      );
    }
  }

  final InvestmentsRepository _investmentsRepository;
  final ExchangeRateRepository _exchangeRateRepository;
  final AuthenticationBloc _authenticationBloc;

  Future<void> _loadMoreInvestments(
    LoadMoreInvestments event,
    Emitter<InvestmentsState> emit,
  ) async {
    if (state is InvestmentsLoaded) {
      final InvestmentsLoaded currentState = state as InvestmentsLoaded;
      if (currentState.isLoadingMore || currentState.hasReachedMax) return;
      // Access the user ID from the AuthenticationBloc's state.
      final String userId = _authenticationBloc.state.user.id;
      if (userId.isEmpty) {
        emit(
          const UnauthenticatedInvestmentsAccessState(
            error: 'User ID not found',
          ),
        );
        return;
      }
      emit(currentState.copyWith(isLoadingMore: true));

      try {
        final int nextPage =
            (currentState.investments.length ~/ constants.itemsPerPage) +
                constants.pageOffset;

        final Investments result = await _investmentsRepository.getInvestments(
          userId: userId,
          page: nextPage,
        );

        emit(
          InvestmentsLoaded(
            investments: <Investment>[
              ...currentState.investments,
              ...result.investments,
            ],
            hasReachedMax: result.currentPage >= result.totalPages,
          ),
        );
      } catch (error, stackTrace) {
        debugPrint(
          'Error while loading more.\n'
          'Stacktrace for an error in $runtimeType: $stackTrace.',
        );
        emit(InvestmentsError(error: error.toString()));
      }
    }
  }
}
