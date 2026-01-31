import 'package:beruang/auth/auth_service.dart';
import 'package:beruang/auth/login_page.dart';
import 'package:beruang/core/constants/spacing.dart';
import 'package:beruang/features/home/home_page.dart';
import 'package:beruang/widgets/app_date_field.dart';
import 'package:beruang/widgets/app_dropdown_field.dart';
import 'package:beruang/widgets/app_text_field.dart';
import 'package:beruang/widgets/app_button.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  DateTime? _selectedDob;
  String? _selectedGender;
  bool _isLoading = false;

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedDob == null || _selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi data')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password tidak sama')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = await _authService.signUp(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        dob: _selectedDob!,
        gender: _selectedGender!,
      );

      if (user != null && context.mounted) {
        // langsung ke HomePage setelah signup sukses
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup gagal: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
                Text('Sign Up', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.xl),

                AppTextField(label: 'Username', controller: _usernameController),
                const SizedBox(height: AppSpacing.md),

                AppTextField(label: 'Email', controller: _emailController),
                const SizedBox(height: AppSpacing.md),

                AppTextField(
                  label: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: AppSpacing.md),

                AppTextField(
                  label: 'Confirm Password',
                  controller: _confirmPasswordController,
                  obscureText: true,
                ),
                const SizedBox(height: AppSpacing.md),

                Row(
                  children: [
                    Expanded(
                      child: AppDateField(
                        label: 'Birth Date',
                        value: _selectedDob,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        onChanged: (date) {
                          setState(() => _selectedDob = date);
                        },
                      ),
                    ),
                    
                    const SizedBox(width: AppSpacing.md),

                    Expanded(
                      child: AppDropdownField<String>(
                        label: 'Gender',
                        value: _selectedGender,
                        items: const [
                          DropdownMenuItem(value: 'Male', child: Text('Male')),
                          DropdownMenuItem(value: 'Female', child: Text('Female')),
                          DropdownMenuItem(value: 'Other', child: Text('Other')),
                        ],
                        onChanged: (v) => setState(() => _selectedGender = v),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xl),

                AppButton(
                  label: 'Sign Up',
                  onPressed: _signup,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: AppSpacing.md),

                // Tambahan: "Already have an account? Login"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    const SizedBox(width: AppSpacing.sm),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
