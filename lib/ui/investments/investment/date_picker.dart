import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    required this.label,
    required this.onChanged,
    this.selectedDate,
    super.key,
  });

  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    final Color? color = Theme.of(context).textTheme.bodyLarge?.color;
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: Text(
          selectedDate != null
              ? DateFormat.yMMMd().add_jm().format(selectedDate!)
              : 'Select Date',
          style: TextStyle(
            color: selectedDate == null ? color?.withOpacity(0.6) : color,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && context.mounted) {
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
  }
}
