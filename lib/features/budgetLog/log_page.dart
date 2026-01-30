import 'package:beruang/core/constants/spacing.dart';
import 'package:beruang/widgets/app_header.dart';
import 'package:flutter/material.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  bool _isScrolled = false;

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
    );
  }

  Widget _buildScrollView(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AppHeader(
        isScrolled: _isScrolled,
        showHomeIcon: true, // ❌ HOME PAGE
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
            Text(
              'Budget Log Content Goes Here',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            
            // Add more content widgets here
          ],
        ),
      ),
    );
  }
}