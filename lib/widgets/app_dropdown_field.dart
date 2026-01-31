import 'package:beruang/core/constants/spacing.dart';
import 'package:flutter/material.dart';

class AppDropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,

      /// warna teks yang terpilih
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
      ),

      /// warna background dropdown
      dropdownColor: Theme.of(context).colorScheme.surfaceContainer,

      /// warna panah dropdown
      iconEnabledColor: Theme.of(context).colorScheme.tertiary,
      iconDisabledColor: Theme.of(context).colorScheme.tertiary,

      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,

        isDense: true,
        contentPadding: EdgeInsets.all(AppSpacing.sm),

        labelStyle: Theme.of(context).textTheme.bodyMedium,
        floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
            
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderCard),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderCard),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
