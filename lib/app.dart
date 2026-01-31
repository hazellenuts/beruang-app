import 'package:beruang/auth/auth_gate.dart';
import 'package:beruang/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BeruangApp extends StatelessWidget {
  const BeruangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beruang',
      theme: AppTheme.lightTheme(),
      home: const AuthGate(),
    );
  }
}