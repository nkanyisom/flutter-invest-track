import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investtrack/application_services/blocs/investments/investments_bloc.dart';
import 'package:models/models.dart';

class AddEditInvestmentDialog extends StatefulWidget {
  const AddEditInvestmentDialog({super.key, this.investment});

  final Investment? investment;

  @override
  State<AddEditInvestmentDialog> createState() =>
      _AddEditInvestmentDialogState();
}

class _AddEditInvestmentDialogState extends State<AddEditInvestmentDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _tickerController;
  late TextEditingController _companyNameController;
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
  }

  @override
  void dispose() {
    _tickerController.dispose();
    _companyNameController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final FormState? formState = _formKey.currentState;
    if (formState != null && !formState.validate()) return;

    setState(() => _isSubmitting = true);
    final Investment? investment = widget.investment;

    if (investment != null) {
      context.read<InvestmentsBloc>().add(
            UpdateInvestmentEvent(
              investment.copyWith(
                ticker: _tickerController.text,
                companyName: _companyNameController.text,
              ),
            ),
          );
    } else {
      context.read<InvestmentsBloc>().add(
            CreateInvestmentEvent(
              investment: Investment.create(
                ticker: _tickerController.text,
                companyName: _companyNameController.text,
                // TODO: complete implementation for the rest.
                // type: type,
                // stockExchange: stockExchange,
                // currency: currency,
                // description: description,
                // quantity: quantity,
                // companyLogoUrl: companyLogoUrl,
                // purchaseDate: purchaseDate,
                // userId: userId,
              ),
            ),
          );
    }
    setState(() => _isSubmitting = false);
    Navigator.of(context).pop(true);
  }

  Future<void> _deleteInvestment() async {
    final Investment? investment = widget.investment;
    if (investment == null) return;

    setState(() => _deleteInProgress = true);

    context.read<InvestmentsBloc>().add(DeleteInvestmentEvent(investment));
    setState(() => _deleteInProgress = false);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.investment == null ? 'Add Investment' : 'Edit Investment',
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _tickerController,
                maxLines: 1,
                minLines: 1,
                decoration: const InputDecoration(
                  labelText: 'Investment ticker.',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a ticker.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _companyNameController,
                maxLines: 2,
                minLines: 1,
                decoration: const InputDecoration(
                  labelText: 'Investment company name',
                  // Align label with multiline input.
                  alignLabelWithHint: true,
                  // Add border for better UX.
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter company name.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
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
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
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
              onPressed:
                  (_isSubmitting || titleValue.text.isEmpty) ? null : _onSubmit,
              child: _isSubmitting
                  ? const SizedBox(
                      width: progressIndicatorSize,
                      height: progressIndicatorSize,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ),
                    )
                  : submitText,
            );
          },
        ),
      ],
    );
  }
}
