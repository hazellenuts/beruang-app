import 'package:flutter/material.dart';
import 'package:beruang/core/constants/category_colors.dart';
import 'package:beruang/core/constants/subcategories.dart';

class CategoryColorUtils {
  static Color background(BudgetCategory category) {
    switch (category) {
      case BudgetCategory.needs:
        return CategoryColors.needsBackground;
      case BudgetCategory.wants:
        return CategoryColors.wantsBackground;
      case BudgetCategory.savings:
        return CategoryColors.savingsBackground;
      case BudgetCategory.donate:
        return CategoryColors.donateBackground;
    }
  }

  static Color outline(BudgetCategory category) {
    switch (category) {
      case BudgetCategory.needs:
        return CategoryColors.needsOutline;
      case BudgetCategory.wants:
        return CategoryColors.wantsOutline;
      case BudgetCategory.savings:
        return CategoryColors.savingsOutline;
      case BudgetCategory.donate:
        return CategoryColors.donateOutline;
    }
  }
}
