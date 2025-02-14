import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppColors.gradientBackground,
        child: SafeArea(
          child: Column(
            children: [
              // App Bar replacement
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // Logo section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 80,
                  width: 80,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            border: const OutlineInputBorder(),
                            labelStyle: const TextStyle(color: Colors.white70),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white38),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: AppColors.inputBackgroundColor,
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: const OutlineInputBorder(),
                            labelStyle: const TextStyle(color: Colors.white70),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white38),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: AppColors.inputBackgroundColor,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
                            labelStyle: const TextStyle(color: Colors.white70),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white38),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: AppColors.inputBackgroundColor,
                          ),
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: const OutlineInputBorder(),
                            labelStyle: const TextStyle(color: Colors.white70),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white38),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: AppColors.inputBackgroundColor,
                          ),
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // TODO: Implement signup logic
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Colors.white.withOpacity(0.2),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,  // Makes the button rectangular
                            ),
                          ),
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
