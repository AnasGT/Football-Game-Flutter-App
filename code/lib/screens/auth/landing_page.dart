import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'login_page.dart';
import 'signup_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppColors.gradientBackground,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 48),  // Increased spacing at top since we removed back button
                // Logo
                Image.asset(
                  'assets/images/logo.png',
                  height: 80,
                  width: 80,
                ),
                const SizedBox(height: 16),
                // Title
                const Column(
                  children: [
                    Text(
                      'Football Game',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Create Your Dream Team',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 64),  // Add more space before buttons
                // Buttons section
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.white.withOpacity(0.2),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpPage()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          side: const BorderSide(color: Colors.white),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Sign Up'),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () {
                          // TODO: Implement Google sign in
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          side: const BorderSide(color: Colors.white),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Continue with Google'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),  // Add bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}
