import 'dart:math';

import 'package:beruang/core/constants/colors.dart';
import 'package:beruang/core/constants/spacing.dart';
import 'package:beruang/core/utils/currency_formatter.dart';
import 'package:flutter/material.dart';

class AppResultCard extends StatelessWidget {
  final String title;
  final double amount;

  const AppResultCard({
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.borderCard),
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),

          const SizedBox(height: AppSpacing.sm),

          /// Amount
          Text(
            CurrencyFormatter.rupiah(amount),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: AppSpacing.sm),

          /// Placeholder content
          Text(
            'to be continued',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.whiteTextColor),
          ),
        ],
      ),
    ));
  }
}