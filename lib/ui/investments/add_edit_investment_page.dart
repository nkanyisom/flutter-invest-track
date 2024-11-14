import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:investtrack/application_services/blocs/investments/investments_bloc.dart';
import 'package:investtrack/res/constants/currency_list.dart' as list;
import 'package:investtrack/res/constants/types.dart' as types;
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
  bool _isSubmitting = false;
  bool _deleteInProgress = false;

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
              _buildTextField(
                controller: _tickerController,
                label: 'Ticker Symbol',
                hint: 'e.g. GOOG',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _companyNameController,
                label: 'Company Name',
                hint: 'e.g. Alphabet Inc Class C',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _companyLogoUrlController,
                label: 'Company Logo URL',
                hint: 'Enter direct image URL.',
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Investment Type',
                value: _investmentType,
                items: types.investmentTypes,
                onChanged: (String? value) =>
                    setState(() => _investmentType = value),
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Stock Exchange',
                value: _stockExchange,
                items: types.stockExchangeTypes,
                onChanged: (String? value) =>
                    setState(() => _stockExchange = value),
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Currency',
                value: _currency,
                items: list.currencies
                    .map((Currency currency) => currency.alphabeticCode)
                    .toList(),
                onChanged: (String? value) => setState(() => _currency = value),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _quantityController,
                label: 'Quantity',
                hint: 'e.g. 100',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              if (_quantityController.text.isNotEmpty &&
                  int.parse(_quantityController.text) > 0)
                _buildDatePicker(
                  label: 'Purchase Date and Time',
                  selectedDate: _purchaseDate,
                  onChanged: (DateTime? value) =>
                      setState(() => _purchaseDate = value),
                ),
              const SizedBox(height: 16),
              _buildTextField(
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
                    TextButton(
                      onPressed: _deleteInProgress ? null : _deleteInvestment,
                      child: _deleteInProgress
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Delete investment.',
                              style: TextStyle(color: Colors.red),
                            ),
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
                      return ElevatedButton(
                        onPressed: (_isSubmitting || titleValue.text.isEmpty)
                            ? null
                            : _onSubmit,
                        child: _isSubmitting
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

  Future<void> _onSubmit() async {
    final FormState? formState = _formKey.currentState;
    if (_purchaseDate != null && formState != null && formState.validate()) {
      setState(() => _isSubmitting = true);
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
                  quantity: int.parse(_quantityController.text),
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
          quantity: int.parse(_quantityController.text),
          purchaseDate: _purchaseDate!,
          description: _descriptionController.text,
        );

        // Dispatch the event to create the investment.
        context
            .read<InvestmentsBloc>()
            .add(CreateInvestmentEvent(investment: newInvestment));
      }

      setState(() => _isSubmitting = false);
      // Close the screen.
      Navigator.of(context).pop(true);
    } else {
      debugPrint('We should not be here, _purchaseDate should not be null.');
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (String? value) {
        return value == null || value.isEmpty ? 'Please enter $label.' : null;
      },
    );
  }

  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? value,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (String? value) =>
          value == null || value.isEmpty ? 'Please select $label.' : null,
    );
  }

  Widget _buildDatePicker({
    required String label,
    required ValueChanged<DateTime?> onChanged,
    DateTime? selectedDate,
  }) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (picked != null && mounted) {
          final TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (time != null) {
            final DateTime fullDateTime = DateTime(
              picked.year,
              picked.month,
              picked.day,
              time.hour,
              time.minute,
            );
            onChanged(fullDateTime);
          }
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: Text(
          selectedDate == null
              ? 'Select Date'
              : DateFormat.yMMMd().add_jm().format(selectedDate),
          style: TextStyle(
            color: selectedDate == null
                ? Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6)
                : Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
    );
  }

  Future<void> _deleteInvestment() async {
    final Investment? investment = widget.investment;
    if (investment == null) return;

    setState(() => _deleteInProgress = true);

    context.read<InvestmentsBloc>().add(DeleteInvestmentEvent(investment));
    setState(() => _deleteInProgress = false);
    Navigator.of(context).pop(true);
  }
}
