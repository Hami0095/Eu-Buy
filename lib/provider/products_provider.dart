import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/category.dart';
import '../model/products_model.dart';
import '../service/product_api_service.dart';

// Product API service provider
final productApiServiceProvider = Provider<ProductApiService>((ref) {
  return ProductApiService();
});

// Provider for all products
final allProductsProvider = FutureProvider<List<Product>>((ref) async {
  final productApiService = ref.watch(productApiServiceProvider);
  return productApiService.getAllProducts();
});

// Provider for a single product by ID
final productByIdProvider =
    FutureProvider.family<Product, int>((ref, id) async {
  final productApiService = ref.watch(productApiServiceProvider);
  return productApiService.getProductById(id);
});

// Provider for limited products
final limitedProductsProvider =
    FutureProvider.family<List<Product>, int>((ref, limit) async {
  final productApiService = ref.watch(productApiServiceProvider);
  return productApiService.getLimitedProducts(limit);
});

// Provider for sorted products
final sortedProductsProvider =
    FutureProvider.family<List<Product>, String>((ref, sort) async {
  final productApiService = ref.watch(productApiServiceProvider);
  return productApiService.getSortedProducts(sort);
});

// Provider for all categories
final allCategoriesProvider = FutureProvider<List<Category>>((ref) async {
  final productApiService = ref.watch(productApiServiceProvider);
  return productApiService.getAllCategories();
});

// Provider for products by category
final productsByCategoryProvider =
    FutureProvider.family<List<Product>, String>((ref, category) async {
  final productApiService = ref.watch(productApiServiceProvider);
  return productApiService.getProductsByCategory(category);
});
