import 'package:ebuy/pages/cart_page.dart';
import 'package:ebuy/pages/favorites_page.dart';
import 'package:ebuy/pages/home_page.dart';
import 'package:ebuy/pages/user_page.dart';
import 'package:ebuy/vintage_theme.dart';
import 'package:flutter/material.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // List of pages
  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),
    const UserPage(),
  ];

  // Handle navigation tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: VintageTheme.primaryColor, // Highlighted color
        unselectedItemColor: VintageTheme.secondaryColor, // Unselected color
        onTap: _onItemTapped,
      ),
    );
  }
}
