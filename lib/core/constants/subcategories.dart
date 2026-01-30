import 'package:flutter/material.dart';

class SubCategory {
  final String label;
  final IconData icon;

  const SubCategory({
    required this.label,
    required this.icon,
  });
}


enum BudgetCategory {
  needs,
  wants,
  savings,
  donate,
}

final Map<BudgetCategory, List<SubCategory>> subCategories = {
  BudgetCategory.needs: const [
    SubCategory(label: 'Food & Drinks', icon: Icons.restaurant),
    SubCategory(label: 'Transportation', icon: Icons.directions_bus),
    SubCategory(label: 'Rent', icon: Icons.home),
    SubCategory(label: 'Utilities', icon: Icons.flash_on),
    SubCategory(label: 'Phone & Data', icon: Icons.phone_android),
    SubCategory(label: 'Health', icon: Icons.local_hospital),
    SubCategory(label: 'Education', icon: Icons.school),
    SubCategory(label: 'Custom', icon: Icons.add_circle_outline),
  ],

  BudgetCategory.wants: const [
    SubCategory(label: 'Coffee & Snacks', icon: Icons.local_cafe),
    SubCategory(label: 'Fashion', icon: Icons.checkroom),
    SubCategory(label: 'Beauty', icon: Icons.brush),
    SubCategory(label: 'Entertainment', icon: Icons.movie),
    SubCategory(label: 'Travel', icon: Icons.flight),
    SubCategory(label: 'Subscriptions', icon: Icons.subscriptions),
    SubCategory(label: 'Custom', icon: Icons.add_circle_outline),
  ],

  BudgetCategory.savings: const [
    SubCategory(label: 'Emergency', icon: Icons.warning),
    SubCategory(label: 'Education', icon: Icons.school),
    SubCategory(label: 'Custom', icon: Icons.add_circle_outline),
  ],

  BudgetCategory.donate: const [
    SubCategory(label: 'Animal Rescue', icon: Icons.pets),
    SubCategory(label: 'Education Support', icon: Icons.menu_book),
    SubCategory(label: 'Children Care', icon: Icons.child_care),
    SubCategory(label: 'Religious Giving', icon: Icons.volunteer_activism),
    SubCategory(label: 'Custom', icon: Icons.add_circle_outline),
  ],
};
