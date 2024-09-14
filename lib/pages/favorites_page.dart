import 'package:ebuy/vintage_theme.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
        backgroundColor: VintageTheme.primaryColor,
      ),
      body: const Center(
        child: Text('Favorites Page'),
      ),
    );
  }
}
