import 'package:beruang/core/utils/currency_formatter.dart';
import 'package:beruang/features/budgetLog/log_page.dart';
import 'package:beruang/features/calculator/calculator_page.dart';
import 'package:beruang/widgets/app_header.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../core/constants/spacing.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isScrolled = false;
  int balance = 25000000;
  
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
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // sudut tumpul
          color: Theme.of(context).colorScheme.tertiaryContainer,
          border: Border.all(
            color: Theme.of(context).colorScheme.onTertiary,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSpacing.md),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CalculatorPage()),
              );
            },
            child: Center(
              child: Icon(
                PhosphorIconsBold.percent,
                size: 30,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollView(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AppHeader(
        isScrolled: _isScrolled,
        showHomeIcon: false, // ❌ HOME PAGE
        onSettingsTap: () {
          // go to settings
        },
      ),
        _buildContent(context),
      ],
    );
  }

  

  Widget _buildContent(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Balance',
                      style: Theme.of(context).textTheme.labelLarge
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      CurrencyFormatter.rupiah(balance),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),

                // statistics button
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const LogPage()));
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      
                    ),
                    child: Icon(
                      PhosphorIconsBold.chartLine,
                      size: AppSpacing.xl,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                )
              ],
            ),

          ]
        ),
      ),
    );
  }
}