import 'package:flutter/material.dart';

import '../utils/create_route.dart';
import '../vintage_theme.dart';
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: VintageTheme
                    .primaryColor, // Correct color from VintageTheme
              ),
            ),
            const SizedBox(height: 40),
            // Name Input Field
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Name',
                prefixIcon:
                    Icon(Icons.person, color: VintageTheme.primaryColor),
              ),
            ),
            const SizedBox(height: 20),
            // Email Input Field
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email, color: VintageTheme.primaryColor),
              ),
            ),
            const SizedBox(height: 20),
            // Username Input Field
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Username',
                prefixIcon: Icon(Icons.person_outline,
                    color: VintageTheme.primaryColor),
              ),
            ),
            const SizedBox(height: 20),
            // Password Input Field
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock, color: VintageTheme.primaryColor),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 40),
            // Sign Up Button
            ElevatedButton(
              onPressed: () {
                // Add sign-up logic here
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: VintageTheme.onPrimaryColor, // Correct color
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Login Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                      color: VintageTheme.onSurfaceColor), // Correct color
                ),
                TextButton(
                  onPressed: () {
                    // Navigate back to LoginPage with fade-out animation
                    Navigator.of(context).push(createRoute(const LoginPage()));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: VintageTheme.primaryColor), // Correct color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
