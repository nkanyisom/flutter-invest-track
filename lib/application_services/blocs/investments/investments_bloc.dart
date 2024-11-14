import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:investtrack/application_services/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:investtrack/domain_services/investments_repository.dart';
import 'package:models/models.dart';

part 'investments_event.dart';
part 'investments_state.dart';

class InvestmentsBloc extends Bloc<InvestmentsEvent, InvestmentsState> {
  InvestmentsBloc(this._investmentsRepository, this._authenticationBloc)
      : super(const InvestmentsInitial()) {
    on<LoadInvestments>((_, Emitter<InvestmentsState> emit) async {
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
      // Fetch investments using the user ID.
      try {
        final List<Investment> investments =
            await _investmentsRepository.getInvestments(
          userId: userId,
        );

        emit(InvestmentsLoaded(investments: investments));
      } catch (error, stackTrace) {
        debugPrint('Stacktrace for an error in $runtimeType: $stackTrace');
        emit(InvestmentsError(error: error.toString()));
      }
    });
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

    on<DeleteInvestmentEvent>((
      DeleteInvestmentEvent event,
      Emitter<InvestmentsState> emit,
    ) async {
      final Investment investment = event.investment;
      emit(
        InvestmentDeleting(
          investmentId: investment.id,
          investments: state.investments,
        ),
      );
      // Get the user ID from the authentication bloc.
      final String userId = _authenticationBloc.state.user.id;

      final MessageResponse response = await _investmentsRepository
          .delete(investment.copyWith(userId: userId));
      // Remove the investment from the existing list of investments.
      final List<Investment> updatedInvestments =
          List<Investment>.from(state.investments)..remove(investment);
      // Emit the new state with the updated list of investments.
      emit(
        InvestmentDeleted(
          message: response.message,
          investments: updatedInvestments,
        ),
      );
    });
  }

  Future<void> _handleCreateOrUpdateInvestment({
    required Emitter<InvestmentsState> emitter,
    required InvestmentsEvent event,
  }) async {
    final List<Investment> investments =
        List<Investment>.from(state.investments);
    if (event is CreateInvestmentEvent) {
      emitter(CreatingInvestment(investments: state.investments));
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
      emitter(
        UpdatingInvestment(
          investmentId: investment.id,
          investments: state.investments,
        ),
      );
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
    }

    // Emit the new state with the updated list of investments.
    emitter(InvestmentSubmitted(investments: investments));
  }

  final InvestmentsRepository _investmentsRepository;
  final AuthenticationBloc _authenticationBloc;
}
