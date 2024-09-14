import 'package:ebuy/pages/home_page.dart';
import 'package:ebuy/pages/navigation_bar.dart';
import 'package:ebuy/pages/sign_up_page.dart';
import 'package:ebuy/provider/user_provider.dart';
import 'package:ebuy/utils/create_route.dart';
import 'package:ebuy/vintage_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: VintageTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 40),
            // Username Input Field
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
                prefixIcon:
                    Icon(Icons.person, color: VintageTheme.primaryColor),
              ),
            ),
            const SizedBox(height: 20),
            // Password Input Field
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock, color: VintageTheme.primaryColor),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 40),
            // Login Button
            ElevatedButton(
              onPressed: () {
                _loginUser(context);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              ),
              child: const Text(
                'Login',
                style:
                    TextStyle(color: VintageTheme.onPrimaryColor, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            // Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: VintageTheme.onSurfaceColor),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to SignUpPage with fade-in animation
                    Navigator.of(context).push(createRoute(const SignUpPage()));
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: VintageTheme.primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _loginUser(BuildContext context) {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      // Trigger login API call with the provided username and password
      final credentials = {'username': username, 'password': password};

      ref.read(loginUserProvider(credentials).future).then((token) {
        // Login successful, print token and navigate to HomePage
        print('User token: ${token.token}');

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainNavigation()),
        );
      }).catchError((error) {
        // Handle error (e.g., invalid credentials)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      });
    } else {
      // Show a message if username or password is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both username and password'),
        ),
      );
    }
  }

  // Route _createRoute(Widget page) {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => page,
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = 0.0;
  //       const end = 1.0;
  //       const curve = Curves.easeInOut;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return FadeTransition(
  //         opacity: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }
}
