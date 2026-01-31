import 'package:beruang/auth/auth_service.dart';
import 'package:beruang/auth/signup_page.dart';
import 'package:beruang/core/constants/spacing.dart';
import 'package:beruang/features/home/home_page.dart';
import 'package:beruang/widgets/app_text_field.dart';
import 'package:beruang/widgets/app_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _hasNavigated = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = await _authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (user != null) {
        _hasNavigated = true;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login gagal: $e')),
      );
    } finally {
      if (mounted && !_hasNavigated) {
        setState(() => _isLoading = false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.xl),

                AppTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Email wajib diisi' : null,
                ),
                const SizedBox(height: AppSpacing.md),

                AppTextField(
                  label: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Password wajib diisi' : null,
                ),
                const SizedBox(height: AppSpacing.xl),

                // pakai AppButton
                AppButton(
                  label: 'Login',
                  onPressed: _login,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: AppSpacing.md),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(width: AppSpacing.sm),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SignupPage()),
                        );
                      },
                      child: Text(
                        'Register',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
