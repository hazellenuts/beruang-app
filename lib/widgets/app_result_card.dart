import 'package:beruang/core/constants/subcategories.dart';
import 'package:beruang/core/utils/category_colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:beruang/core/constants/spacing.dart';
import 'package:beruang/core/utils/currency_formatter.dart';

class AppResultCard extends StatefulWidget {
  final String title;
  final double amount;
  final BudgetCategory category;
  final ValueChanged<bool> onBalanceChanged;

  const AppResultCard({
    required this.title,
    required this.amount,
    required this.category,
    required this.onBalanceChanged,
    super.key,
  });

  @override
  State<AppResultCard> createState() => _AppResultCardState();
}

class _AppResultCardState extends State<AppResultCard> {
  late List<_SubItem> subItems = [];

  @override
  void initState() {
    super.initState();
    subItems = []; // Kosong dulu
  }

  double get allocationDifference {
    return widget.amount - allocatedAmount;
  }

  String get allocationText {
    if (allocationDifference == 0) {
      return 'Balanced';
    }

    final absValue = allocationDifference.abs();
    final sign = allocationDifference > 0 ? '+' : '-';
    return '$sign${CurrencyFormatter.rupiah(absValue)}';
  }

  Color allocationColor(BuildContext context) {
    if (allocationDifference == 0) {
      return Theme.of(context).colorScheme.tertiary;
    }

    // masih sisa (butuh nambah alokasi)
    if (allocationDifference > 0) {
      return Theme.of(context).colorScheme.tertiary;
    }

    // kelebihan input (over budget)
    return Theme.of(context).colorScheme.onSecondary;
  }



  double get allocatedAmount {
    return subItems.fold(0, (sum, item) {
      final val = double.tryParse(item.controller.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      return sum + val;
    });
  }
  
  bool get isBalanced => allocationDifference == 0;

  void _onCurrencyChanged({
    required TextEditingController controller,
    required String value,
  }) {
    final clean = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (clean.isEmpty) {
      controller.value = const TextEditingValue(text: '');
      setState(() {});
      return;
    }

    double parsed = double.tryParse(clean) ?? 0;

    // 🔴 BATAS MAKSIMUM
    if (parsed > CurrencyFormatter.maxBalance) {
      parsed = CurrencyFormatter.maxBalance;
    }

    final formatted = CurrencyFormatter.rupiah(parsed);

    controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );

    setState(() {
      widget.onBalanceChanged(isBalanced);
    });
  }



  void _addNewSubcategory() async {
    final availableSubs = subCategories[widget.category]!;

    // Map untuk menandai checkbox: sudah ada = true, belum ada = false
    final Map<SubCategory, bool> selectedMap = {
      for (var s in availableSubs)
      s: subItems.any((item) => item.subCategory == s),
    };


    final result = await showDialog<List<SubCategory>>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Select Subcategories'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9, // 80% layar
              height: MediaQuery.of(context).size.height * 0.5, // 50% layar
              child: SingleChildScrollView(
                child: Column(
                  children: availableSubs.map((s) {
                    return CheckboxListTile(
                      value: selectedMap[s],
                      controlAffinity: ListTileControlAffinity.trailing,
                      fillColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return Theme.of(context).colorScheme.onBackground;
                        }
                        return Colors.transparent;
                      }),
                      
                      checkColor: Theme.of(context).colorScheme.tertiary,

                      side: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary,
                        width: 2,
                      ),

                      title: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(AppSpacing.xs),
                            child: Icon(s.icon, size: AppSpacing.md, color: CategoryColorUtils.outline(widget.category)),
                            decoration: BoxDecoration(
                              color: CategoryColorUtils.background(widget.category),
                              border: Border.all(
                                color: CategoryColorUtils.outline(widget.category),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(AppSpacing.xs),
                            ),
                          ),
                          
                          const SizedBox(width: 8),
                          Text(s.label, style: Theme.of(context).textTheme.labelSmall),
                        ],
                    ),
                    onChanged: (v) {
                      setState(() {
                        selectedMap[s] = v ?? false;
                      });
                      widget.onBalanceChanged(isBalanced);
                    },
                  );
                }).toList(),
              ),
            ),),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // Ambil semua yang dicek
                  final selectedSubs = selectedMap.entries
                      .where((e) => e.value)
                      .map((e) => e.key)
                      .toList();
                  Navigator.pop(context, selectedSubs);
                },
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary)),
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                  ),
              ),
            ],
          );
        },
      ),
    );

    if (result != null) {
      setState(() {
        // 1️⃣ Hapus yang di-uncheck
        subItems.removeWhere(
          (item) => !result.contains(item.subCategory),
        );

        // 2️⃣ Tambahkan yang baru dicheck
        for (var s in result) {
          if (!subItems.any((item) => item.subCategory == s)) {
            subItems.add(
              _SubItem(
                subCategory: s,
                controller: TextEditingController(),
              ),
            );
          }
        }
      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.borderCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(widget.title, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: AppSpacing.xs),

          // Total Amount
          Text(CurrencyFormatter.rupiah(widget.amount),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSpacing.xl),

          // Budget Allocation (allocated)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Budget Allocation', style: Theme.of(context).textTheme.labelMedium),
              Text(
                allocationText,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: allocationColor(context),
                      fontStyle: FontStyle.italic
                    ),
              ),

            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // List subitems (zebra background)
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                  width: 2
                ),
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                  width: 2
                )
              )
            ),
            child: Column(
              children: subItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;

                  final bgColor = index.isEven
                  ? Theme.of(context).colorScheme.surfaceTint
                  : Colors.transparent;
                  
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    color: bgColor,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          decoration: BoxDecoration(
                            color: CategoryColorUtils.background(widget.category),
                            border: Border.all(
                              color: CategoryColorUtils.outline(widget.category),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(AppSpacing.xs),
                          ),
                          child: Icon(
                            item.subCategory.icon,
                            size: AppSpacing.md,
                            color: CategoryColorUtils.outline(widget.category),
                          ),
                        ),

                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.subCategory.label,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: item.controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Rp0',
                              hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                              isDense: true,
                              contentPadding: const EdgeInsets.all(AppSpacing.xs),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  width: 1,
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  width: 2,
                                ),
                              ),
                            ),
                            style: Theme.of(context).textTheme.bodySmall,
                            onChanged: (value) {
                              _onCurrencyChanged(
                                controller: item.controller,
                                value: value,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          
          const SizedBox(height: AppSpacing.lg,),
      
          FilledButton(
            onPressed: _addNewSubcategory, 
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.tertiary),
            ),
            child: Center(
              child: Text(
                'Add New',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.surface),
                ),
              ),
            )
        ],
      ),

      
    );

    
  }
}

class _SubItem {
  final SubCategory subCategory;
  final TextEditingController controller;

  _SubItem({required this.subCategory, required this.controller});
}
