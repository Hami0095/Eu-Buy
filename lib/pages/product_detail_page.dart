import 'package:ebuy/model/products_model.dart';
import 'package:ebuy/model/cart_model.dart';
import 'package:ebuy/provider/carts_provider.dart';
import 'package:ebuy/service/cart_api_service.dart';
import 'package:ebuy/vintage_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Assuming you have a method to get the current user ID
int getCurrentUserId() {
  // Replace this with actual logic to get the current user ID
  return 1;
}

class ProductDetailPage extends ConsumerWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = getCurrentUserId(); // Get current user ID

    return Scaffold(
      appBar: AppBar(
        foregroundColor: VintageTheme.onPrimaryColor,
        title: const Text(
          'Product Details',
          style: TextStyle(color: VintageTheme.onPrimaryColor),
        ),
        backgroundColor: VintageTheme.secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Center(
                child: Image.network(
                  product.image,
                  height: 250,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Product Title
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: VintageTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            // Product Price
            Text(
              '\$${product.price.toString()}',
              style: const TextStyle(
                fontSize: 20,
                color: VintageTheme.secondaryColor,
              ),
            ),
            const SizedBox(height: 20),
            // Product Description
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16,
                color: VintageTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            // Add to Cart Button
            ElevatedButton(
              onPressed: () async {
                final cartApiService = ref.read(cartApiServiceProvider);

                try {
                  // Fetch user carts
                  final userCartsResponse =
                      await ref.watch(userCartsProvider(userId).future);

                  // Check if user has a cart, if not create a new one
                  if (userCartsResponse.isEmpty) {
                    // Create a new cart for the user
                    final newCart = Cart(
                      id: 0, // ID will be assigned by the API
                      userId: userId,
                      products: [
                        CartProduct(productId: product.id, quantity: 1)
                      ],
                      date: DateTime.now().toString(),
                    );

                    await cartApiService.addCart(newCart);
                  } else {
                    // Get the existing cart
                    final existingCart = userCartsResponse.first;

                    // Add the new product to the existing cart
                    existingCart.products
                        .add(CartProduct(productId: product.id, quantity: 1));

                    await cartApiService.updateCart(
                        existingCart.id, existingCart);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added to cart!'),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: VintageTheme.onPrimaryColor,
                backgroundColor: VintageTheme.primaryColor,
              ),
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
