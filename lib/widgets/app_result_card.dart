import 'dart:math';

import 'package:beruang/core/constants/colors.dart';
import 'package:beruang/core/constants/spacing.dart';
import 'package:beruang/core/utils/currency_formatter.dart';
import 'package:beruang/widgets/app_slider.dart';
import 'package:flutter/material.dart';

class AppResultCard extends StatefulWidget {
  final String title;
  final double amount;

  const AppResultCard({
    required this.title,
    required this.amount,
  });

  @override
  State<AppResultCard> createState() => _AppResultCardState();
}

class _AppResultCardState extends State<AppResultCard> {
  /// 3 thumb = 4 kategori
  List<int> thumbs = [20, 50, 80];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.borderCard),
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            widget.title,
            style: Theme.of(context).textTheme.labelLarge,
          ),

          const SizedBox(height: AppSpacing.sm),

          /// Amount
          Text(
            CurrencyFormatter.rupiah(widget.amount),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: AppSpacing.xl),

          /// Placeholder content
          Text(
            'Budget Allocation',
            style: Theme.of(context)
                .textTheme
                .labelMedium
          ),

          AppSlider(
                    values: thumbs,
                    onChanged: (v) {
                      setState(() => thumbs = v);
                    },
                  ),
        ],
      ),
    ));
  }
}