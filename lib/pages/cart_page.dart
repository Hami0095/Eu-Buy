import 'dart:convert';
import 'package:ebuy/provider/carts_provider.dart';
import 'package:ebuy/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const userId = 1; // For testing purposes

    final cartProvider = ref.watch(userCartsProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cartProvider.when(
        data: (carts) {
          if (carts.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          return ListView.builder(
            itemCount: carts.length,
            itemBuilder: (context, index) {
              final cart = carts[index];
              return ExpansionTile(
                title: Text('Cart ID: ${cart.id}'),
                subtitle: Text('Date: ${cart.date}'),
                children: cart.products.map((cartProduct) {
                  return Consumer(
                    builder: (context, ref, child) {
                      final productFuture =
                          ref.watch(productByIdProvider(cartProduct.productId));

                      return productFuture.when(
                        data: (product) {
                          return ListTile(
                            leading: Image.network(product.image,
                                width: 50, height: 50),
                            title: Text(product.title),
                            subtitle: Text('Quantity: ${cartProduct.quantity}'),
                            trailing: Text(
                                '\$${(product.price * cartProduct.quantity).toStringAsFixed(2)}'),
                          );
                        },
                        loading: () =>
                            const ListTile(title: Text('Loading product...')),
                        error: (error, stack) => const ListTile(
                            title: Text('Error loading product')),
                      );
                    },
                  );
                }).toList(),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            // Initialize Stripe with your publishable key
            Stripe.publishableKey =
                'pk_test_51NDNJ6SH1SlKeseqGg5sIUH7UbVc9HuTA2KQwwzUdV2Q2xxTJYRGkthnMIeBfvlmdo2f8sVtQT913AO330LVf9RA00GxyBrTDa';

            try {
              // Step 1: Create Payment Intent on your server (Simulating this with client-side call)
              final paymentIntentData = await createPaymentIntent(
                  '1000', 'usd'); // For testing purposes, amount: 1000 cents

              // Step 2: Initialize the payment sheet with Payment Intent Client Secret
              await Stripe.instance.initPaymentSheet(
                paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntentData['client_secret'],
                  style: ThemeMode.light,
                  merchantDisplayName: 'EUBuy',
                ),
              );

              // Step 3: Present the payment sheet
              await Stripe.instance.presentPaymentSheet();

              // Step 4: Show dialog after successful payment
              showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Order Placed'),
                  content: Text(
                      'Your order has been placed successfully. Order ID: ${const Uuid().v4()}'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                        Navigator.pop(
                            context); // Go back to the previous screen
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );

              // Reset navigation index to 0
              // ignore: use_build_context_synchronously
              Navigator.popUntil(context, (route) => route.isFirst);
            } catch (e) {
              debugPrint("$e");
            }
          },
          child: const Text('Checkout'),
        ),
      ),
    );
  }

  // Simulate a backend API call to create a Payment Intent (in a real-world app, this would be on your backend server)
  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51NDNJ6SH1SlKeseqx88FkI8l6AVfsVdNOau2NbBdpLsqCk1RbGhPN78QysmnVB9kxOiK71ITWf8PKaBg2pln0lUC00EwSXRTGA',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      print('Error creating payment intent: $err');
      throw Exception(err);
    }
  }
}
