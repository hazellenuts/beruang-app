import 'package:beruang/core/constants/category_colors.dart';
import 'package:beruang/core/constants/subcategories.dart';
import 'package:beruang/features/budgetLog/log_page.dart';
import 'package:beruang/widgets/app_date_field.dart';
import 'package:beruang/widgets/app_result_card.dart';
import 'package:beruang/core/constants/spacing.dart';
import 'package:beruang/core/utils/currency_formatter.dart';
import 'package:beruang/core/utils/slider_utils.dart';
import 'package:beruang/widgets/app_button.dart';
import 'package:beruang/widgets/app_distribution_card.dart';
import 'package:beruang/widgets/app_header.dart';
import 'package:beruang/widgets/app_slider.dart';
import 'package:beruang/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});
  

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  double balance = 0;
  DateTime? _selectedDate;
  bool showResult = false;
  bool _isScrolled = false;
  static const double maxBalance = 9999999999999;
  bool get allBalanced => categoryBalanceStatus.values.every((v) => v == true);

  
  final budgetCategories = [
    BudgetCategory.needs,
    BudgetCategory.wants,
    BudgetCategory.savings,
    BudgetCategory.donate,
  ];


  /// 3 thumb = 4 kategori
  List<int> thumbs = [20, 50, 80];

  final TextEditingController balanceController = TextEditingController();

  final categories = [
    (label: 'Needs', color: CategoryColors.needsChart),
    (label: 'Wants', color: CategoryColors.wantsChart),
    (label: 'Savings', color: CategoryColors.savingsChart),
    (label: 'Donate', color: CategoryColors.donateChart),
  ];

  final Map<BudgetCategory, bool> categoryBalanceStatus = {
    BudgetCategory.needs: false,
    BudgetCategory.wants: false,
    BudgetCategory.savings: false,
    BudgetCategory.donate: false,
  };



  @override
  void dispose() {
    balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels > 0 && !_isScrolled) {
            setState(() {
              _isScrolled = true;
            });
          } else if (notification.metrics.pixels <= 0 && _isScrolled) {
            setState(() {
              _isScrolled = false;
            });
          }
          return false;
        },
        child: _buildScrollView(context)
      ),
    );}

  Widget _buildScrollView(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AppHeader(
        isScrolled: _isScrolled,
        showHomeIcon: true,
        onSettingsTap: () {
          // go to settings
        },
      ),
        _buildContent(context),
      ],
  );
  }

  Widget _buildContent(BuildContext context) {
    final percents = SliderUtils.calculatePercents(thumbs, 100);
    return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ===== BALANCE =====
                  Text(
                    'Balance',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  AppTextField(
                    hint: 'Ex: Rp3.000.000',
                    controller: balanceController,
                    keyboardType: TextInputType.number,
                    hideLabel: true,
                    onChanged: (value) {
                      final clean = value.replaceAll(RegExp(r'[^0-9]'), '');

                      if (clean.isEmpty) {
                        setState(() {
                          balance = 0;
                        });
                        return;
                      }

                      double parsed = double.tryParse(clean) ?? 0;

                      // 🚨 CLAMP ke maksimum
                      if (parsed > maxBalance) {
                        parsed = maxBalance;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Maximum value of balance is Rp9,999,999,999,999'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }

                      setState(() {
                        balance = parsed;

                        final formatted = CurrencyFormatter.rupiah(balance);
                        balanceController.value = balanceController.value.copyWith(
                          text: formatted,
                          selection: TextSelection.collapsed(offset: formatted.length),
                        );
                      });
                    },

                  ),

                  const SizedBox(height: AppSpacing.xl),

                  /// ===== NOTES & DATE =====
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Notes',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            AppTextField(
                              hint: 'Catatan',
                              hideLabel: true,
                              controller: TextEditingController(),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: AppSpacing.md),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: AppSpacing.sm),

                            AppDateField(
                              label: 'DD/MM/YY',
                              value: _selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                              onChanged: (date) {
                                setState(() => _selectedDate = date);
                              },
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  /// ===== DISTRIBUTION =====
                  Text(
                    'Distribution',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  DistributionCard(
                    categories: categories,
                    percents: percents,
                    balance: balance,
                  ),

                  

                  const SizedBox(height: AppSpacing.sm),

                  AppSlider(
                    values: thumbs,
                    onChanged: (v) {
                      setState(() => thumbs = v);
                    },
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  AppButton(
                    label: 'Calculate', 
                    onPressed: (){
                      setState(() {
                        showResult = true;
                      });
                    }
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  if (showResult) ...[
                    ...List.generate(categories.length, (i) {
                      final amount = balance * percents[i] / 100;

                      return AppResultCard(
                        title: categories[i].label,
                        amount: amount,
                        category: budgetCategories[i],
                        onBalanceChanged: (isBalanced) {
                          setState(() {
                            categoryBalanceStatus[budgetCategories[i]] = isBalanced;
                          });
                        },
                      );
                    }),

                    const SizedBox(height: AppSpacing.md),

                    AppButton(
                      label: 'Add',
                      onPressed: allBalanced
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const LogPage()),
                              );
                            }
                          : () {},

                      backgroundColor: allBalanced
                          ? Theme.of(context).colorScheme.primary
                          : Color.fromARGB(56, 153, 169, 151),

                      textColor: allBalanced
                          ? Theme.of(context).colorScheme.onPrimary
                          : Color.fromARGB(65, 76, 119, 72),
                    ),


                    const SizedBox(height: AppSpacing.md),

                  ],

                  


                ],
              ),
            ),
          );
  }
}

