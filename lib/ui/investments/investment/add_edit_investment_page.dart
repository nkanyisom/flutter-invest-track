import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investtrack/application_services/blocs/investments/investments_bloc.dart';
import 'package:investtrack/res/constants/currency_list.dart' as list;
import 'package:investtrack/res/constants/types.dart' as types;
import 'package:investtrack/ui/investments/investment/date_picker.dart';
import 'package:investtrack/ui/investments/investment/dropdown_field.dart';
import 'package:investtrack/ui/investments/investment/labeled_text_field.dart';
import 'package:models/models.dart';

class AddEditInvestmentPage extends StatefulWidget {
  const AddEditInvestmentPage({super.key, this.investment});

  final Investment? investment;

  @override
  State<AddEditInvestmentPage> createState() => _AddEditInvestmentPageState();
}

class _AddEditInvestmentPageState extends State<AddEditInvestmentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _tickerController;
  late TextEditingController _companyNameController;
  late TextEditingController _companyLogoUrlController;
  late TextEditingController _quantityController;
  late TextEditingController _descriptionController;
  DateTime? _purchaseDate;
  String? _investmentType;
  String? _stockExchange;
  String? _currency;

  @override
  void initState() {
    super.initState();
    _tickerController = TextEditingController(
      text: widget.investment?.ticker ?? '',
    );
    _companyNameController = TextEditingController(
      text: widget.investment?.companyName ?? '',
    );
    _companyLogoUrlController = TextEditingController(
      text: widget.investment?.companyLogoUrl ?? '',
    );
    _quantityController = TextEditingController(
      text: widget.investment?.quantity.toString() ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.investment?.description ?? '',
    );
    _purchaseDate = widget.investment?.purchaseDate;
    _investmentType = widget.investment?.type;
    _stockExchange = widget.investment?.stockExchange;
    _currency = widget.investment?.currency;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.investment == null ? 'Add Investment' : 'Edit Investment',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LabeledTextField(
                controller: _tickerController,
                label: 'Ticker Symbol',
                hint: 'e.g. GOOG',
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                controller: _companyNameController,
                label: 'Company Name',
                hint: 'e.g. Alphabet Inc Class C',
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                controller: _companyLogoUrlController,
                label: 'Company Logo URL',
                hint: 'Enter direct image URL.',
              ),
              const SizedBox(height: 16),
              DropdownField(
                label: 'Investment Type',
                value: _investmentType,
                items: types.investmentTypes,
                onChanged: (String? value) =>
                    setState(() => _investmentType = value),
              ),
              const SizedBox(height: 16),
              DropdownField(
                label: 'Stock Exchange',
                value: _stockExchange,
                items: types.stockExchangeTypes,
                onChanged: (String? value) =>
                    setState(() => _stockExchange = value),
              ),
              const SizedBox(height: 16),
              DropdownField(
                label: 'Currency',
                value: _currency,
                items: list.currencies
                    .map((Currency currency) => currency.alphabeticCode)
                    .toList(),
                onChanged: (String? value) => setState(() => _currency = value),
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                controller: _quantityController,
                label: 'Quantity',
                hint: 'e.g. 100',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _quantityController,
                builder: (_, TextEditingValue value, __) {
                  final String text = value.text;
                  final int? quantity = int.tryParse(text);
                  final bool isQuantityValid =
                      text.isNotEmpty && quantity != null && quantity > 0;

                  if (!isQuantityValid) return const SizedBox.shrink();

                  return DatePicker(
                    label: 'Purchase Date and Time',
                    selectedDate: _purchaseDate,
                    onChanged: (DateTime? value) =>
                        setState(() => _purchaseDate = value),
                  );
                },
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Enter a description',
                maxLines: 5,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (widget.investment != null)
                    BlocBuilder<InvestmentsBloc, InvestmentsState>(
                      builder: (_, InvestmentsState state) {
                        return TextButton(
                          onPressed: state is InvestmentDeleting
                              ? null
                              : _deleteInvestment,
                          child: state is InvestmentDeleting
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Delete investment',
                                  style: TextStyle(color: Colors.red),
                                ),
                        );
                      },
                    ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _tickerController,
                    child: const Text('Submit'),
                    builder: (
                      _,
                      TextEditingValue titleValue,
                      Widget? submitText,
                    ) {
                      const double progressIndicatorSize = 24.0;
                      return BlocConsumer<InvestmentsBloc, InvestmentsState>(
                        listener: (
                          BuildContext context,
                          InvestmentsState state,
                        ) {
                          if (state is InvestmentSubmitted) {
                            context
                                .read<InvestmentsBloc>()
                                .add(LoadInvestment(state.investment));
                            // Close the screen.
                            Navigator.of(context).pop(state.investment);
                          } else if (state is InvestmentsError) {
                            // Show a snackbar with the error message.
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.error),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (state is InvestmentDeleted) {
                            Navigator.of(context).pop(true);
                          }
                        },
                        builder: (_, InvestmentsState state) {
                          final bool isSubmitting =
                              state is UpdatingInvestment ||
                                  state is CreatingInvestment;
                          return ElevatedButton(
                            onPressed: (isSubmitting || titleValue.text.isEmpty)
                                ? null
                                : _submit,
                            child: isSubmitting
                                ? const SizedBox(
                                    width: progressIndicatorSize,
                                    height: progressIndicatorSize,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                      ),
                                    ),
                                  )
                                : submitText,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tickerController.dispose();
    _companyNameController.dispose();
    _companyLogoUrlController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final FormState? formState = _formKey.currentState;
    if (formState != null && formState.validate()) {
      final Investment? investment = widget.investment;
      if (investment != null) {
        context.read<InvestmentsBloc>().add(
              UpdateInvestmentEvent(
                investment.copyWith(
                  ticker: _tickerController.text,
                  companyName: _companyNameController.text,
                  companyLogoUrl: _companyLogoUrlController.text,
                  type: _investmentType ?? '',
                  stockExchange: _stockExchange ?? '',
                  currency: _currency ?? '',
                  quantity: int.tryParse(_quantityController.text),
                  purchaseDate: _purchaseDate,
                  description: _descriptionController.text,
                ),
              ),
            );
      } else {
        // Collect form data and create the investment object.
        final Investment newInvestment = Investment.base(
          ticker: _tickerController.text,
          companyName: _companyNameController.text,
          companyLogoUrl: _companyLogoUrlController.text,
          type: _investmentType ?? '',
          stockExchange: _stockExchange ?? '',
          currency: _currency ?? '',
          quantity: int.tryParse(_quantityController.text) ?? 0,
          purchaseDate: _purchaseDate!,
          description: _descriptionController.text,
        );

        // Dispatch the event to create the investment.
        context
            .read<InvestmentsBloc>()
            .add(CreateInvestmentEvent(investment: newInvestment));
      }
    } else {
// Handle invalid form case.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill out all required fields correctly.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteInvestment() async {
    final Investment? investment = widget.investment;
    if (investment == null) return;
    context.read<InvestmentsBloc>().add(DeleteInvestmentEvent(investment));
  }
}
