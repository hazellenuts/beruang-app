import 'package:flutter/material.dart';
import 'package:beruang/core/constants/colors.dart';
import 'package:beruang/core/constants/spacing.dart';
import 'package:beruang/core/utils/currency_formatter.dart';

class DistributionCard extends StatelessWidget {
  final List<({String label, Color color})> categories;
  final List<double> percents;
  final double balance;

  const DistributionCard({
    super.key,
    required this.categories,
    required this.percents,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.borderCard),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        children: List.generate(categories.length, (i) {
          return _buildRow(
            context,
            categories[i].label,
            percents[i],
            balance * percents[i] / 100,
            categories[i].color,
          );
        }),
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    String label,
    double percent,
    double amount,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$label ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.whiteTextColor),
                ),
                TextSpan(
                  text: '(${percent.toInt()}%)',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: color),
                ),
              ],
            ),
          ),
          Text(
            CurrencyFormatter.rupiah(amount),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(
                  color: AppColors.whiteTextColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
