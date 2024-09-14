import 'package:ebuy/pages/product_detail_page.dart';
import 'package:ebuy/vintage_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/products_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String _selectedCategory = 'All'; // Default is "All" to show all products

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EBuy',
          style: TextStyle(
            color: VintageTheme.onPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: VintageTheme.primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // Category Chip List
          SizedBox(
            height: 50,
            child: _buildCategoryChips(context),
          ),
          const SizedBox(height: 10),
          // Product Grid
          Expanded(
            child: _buildProductGrid(context),
          ),
        ],
      ),
    );
  }

  // Function to build Category Chip List
  Widget _buildCategoryChips(BuildContext context) {
    final categoryList = [
      "All",
      "electronics",
      "jewelery",
      "men's clothing",
      "women's clothing"
    ];
    return ListView(
      scrollDirection: Axis.horizontal,
      children: categoryList.map((category) {
        final bool isSelected = _selectedCategory == category;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ChoiceChip(
            label: Text(category),
            selected: isSelected,
            selectedColor: VintageTheme.primaryColor,
            onSelected: (selected) {
              setState(() {
                _selectedCategory = category;
              });
            },
            labelStyle: TextStyle(
              color: isSelected
                  ? VintageTheme.onPrimaryColor
                  : VintageTheme.primaryColor,
            ),
          ),
        );
      }).toList(),
    );
  }

  // Function to build Product Grid based on category selection
  Widget _buildProductGrid(BuildContext context) {
    final productProvider = _selectedCategory == 'All'
        ? allProductsProvider // Fetch all products if "All" is selected
        : productsByCategoryProvider(
            _selectedCategory); // Fetch products by selected category

    return Consumer(
      builder: (context, ref, child) {
        final productsAsyncValue = ref.watch(productProvider);

        return productsAsyncValue.when(
          data: (products) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 3,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to product details page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Product Image
                        Container(
                          color: Colors.white,
                          child: Image.network(
                            product.image,
                            fit: BoxFit.contain,
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Product Name
                        Text(
                          product.title,
                          style: const TextStyle(
                            color: VintageTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Product Price
                        Text(
                          '\$${product.price.toString()}',
                          style: const TextStyle(
                            color: VintageTheme.secondaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        );
      },
    );
  }
}
