import 'package:flutter/material.dart';
import 'package:beruang/widgets/app_text_field.dart';

class AppDateField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onChanged;

  const AppDateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.firstDate,
    required this.lastDate,
  });

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? lastDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Theme.of(context).colorScheme.onPrimary,
              surface: Theme.of(context).colorScheme.background,
              onSurface: Theme.of(context).colorScheme.onBackground,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: label,
      readOnly: true,
      controller: TextEditingController(
        text: value == null
            ? ''
            : '${value!.day}/${value!.month}/${value!.year}',
      ),
      onTap: () => _pickDate(context),
    );
  }
}
