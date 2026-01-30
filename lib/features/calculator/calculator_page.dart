import 'package:beruang/core/constants/category_colors.dart';
import 'package:beruang/core/constants/colors.dart';
import 'package:beruang/core/constants/spacing.dart';
import 'package:beruang/core/utils/currency_formatter.dart';
import 'package:beruang/widgets/app_header.dart';
import 'package:beruang/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  double balance = 0;
  DateTime? _selectedDate;

 
  RangeValues distribution = const RangeValues(50, 80);

  final TextEditingController balanceController = TextEditingController();

  @override
  void dispose() {
    balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final needsPercent = distribution.start;
    final wantsPercent = distribution.end - distribution.start;
    final savingsPercent = 100 - distribution.end;

    final needsAmount = balance * needsPercent / 100;
    final wantsAmount = balance * wantsPercent / 100;
    final savingsAmount = balance * savingsPercent / 100;

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) => false,
        child: CustomScrollView(
          slivers: [
            AppHeader(
              isScrolled: false,
              showHomeIcon: true,
              onSettingsTap: () {},
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ===== BALANCE =====
                    Text(
                      'Balance',
                      style: Theme.of(context).textTheme.labelLarge
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    AppTextField(
                      hint: 'Ex: Rp3.000.000',
                      controller: balanceController,
                      keyboardType: TextInputType.number,
                      hideLabel: true,
                      onChanged: (value) {
                        final cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                        setState(() {
                          balance = double.tryParse(cleanValue) ?? 0;
                          balanceController.value = balanceController.value.copyWith(
                            text: CurrencyFormatter.rupiah(balance),
                            selection: TextSelection.collapsed(
                              offset: CurrencyFormatter.rupiah(balance).length,
                            ),
                          );
                        });
                      },
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // ===== NOTES & DATE =====
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Notes',
                                style: Theme.of(context).textTheme.labelLarge
                              ),
                              const SizedBox(height: AppSpacing.sm),
                                  
                              AppTextField(
                                hint: 'Catatan',
                                controller: TextEditingController(),
                                hideLabel: true,
                              ),

                            ],
                          )
                          
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: Theme.of(context).textTheme.labelLarge
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              AppTextField(
                                hint: 'Date',
                                readOnly: true,
                                hideLabel: true,
                                controller: TextEditingController(
                                  text: _selectedDate == null
                                      ? ''
                                      : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                ),
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now(),
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      _selectedDate = picked;
                                    });
                                  }
                                },
                              ),
                            ],
                          )
                          
                          
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    /// ===== DISTRIBUTION =====
                    Text(
                      'Distribution',
                      style: Theme.of(context).textTheme.labelLarge
                    ),
                    const SizedBox(height: AppSpacing.md),

                    _buildRow(
                      'Needs',
                      needsPercent,
                      needsAmount,
                      CategoryColors.needsBackground,
                    ),
                    _buildRow(
                      'Wants',
                      wantsPercent,
                      wantsAmount,
                      CategoryColors.wantsBackground,
                    ),
                    _buildRow(
                      'Savings',
                      savingsPercent,
                      savingsAmount,
                      CategoryColors.savingsBackground,
                    ),

                    const SizedBox(height: AppSpacing.md),

                    RangeSlider(
                      values: distribution,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      labels: RangeLabels(
                        '${distribution.start.toInt()}%',
                        '${distribution.end.toInt()}%',
                      ),
                      activeColor: AppColors.primary,
                      onChanged: (values) {
                        setState(() {
                          distribution = values;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
      String label, double percent, double amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label (${percent.toInt()}%)',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            CurrencyFormatter.rupiah(amount),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
