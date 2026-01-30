import 'package:beruang/core/constants/colors.dart';
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
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // sudut tumpul
          gradient: const LinearGradient(
            colors: [Color(0xFF8769CD), Color(0xFFFFCA96)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: Color(0xFF433C66),
            width: 5,
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
            child: const Center(
              child: Icon(
                Icons.add,
                size: 32,
                color: Color(0xFF433C66),
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
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      
                    ),
                    child: Icon(
                      PhosphorIcons.chartBar(PhosphorIconsStyle.fill),
                      color: AppColors.accent,
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