import 'package:beruang/core/constants/colors.dart';
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
      style: const TextStyle(
        color: AppColors.whiteTextColor,
      ),

      /// warna background dropdown
      dropdownColor: AppColors.surface,

      /// warna panah dropdown
      iconEnabledColor: AppColors.outline,
      iconDisabledColor: AppColors.outline,

      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppColors.surface,

        labelStyle: const TextStyle(color: AppColors.outline),
        floatingLabelStyle:
            const TextStyle(color: AppColors.whiteTextColor),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderCard),
          borderSide: const BorderSide(color: AppColors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderCard),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
