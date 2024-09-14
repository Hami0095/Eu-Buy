import 'package:ebuy/model/cart_model.dart';
import 'package:ebuy/service/cart_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Cart API service provider
final cartApiServiceProvider = Provider<CartApiService>((ref) {
  return CartApiService();
});

// Provider for all carts
final allCartsProvider = FutureProvider<List<Cart>>((ref) async {
  final cartApiService = ref.watch(cartApiServiceProvider);
  return cartApiService.getAllCarts();
});

// Provider for a single cart by ID
final cartByIdProvider = FutureProvider.family<Cart, int>((ref, id) async {
  final cartApiService = ref.watch(cartApiServiceProvider);
  return cartApiService.getCartById(id);
});

// Provider for limited carts
final limitedCartsProvider =
    FutureProvider.family<List<Cart>, int>((ref, limit) async {
  final cartApiService = ref.watch(cartApiServiceProvider);
  return cartApiService.getLimitedCarts(limit);
});

// Provider for sorted carts
final sortedCartsProvider =
    FutureProvider.family<List<Cart>, String>((ref, sort) async {
  final cartApiService = ref.watch(cartApiServiceProvider);
  return cartApiService.getSortedCarts(sort);
});

// Provider for carts by date range
final cartsByDateRangeProvider =
    FutureProvider.family<List<Cart>, Map<String, String>>(
        (ref, dateRange) async {
  final cartApiService = ref.watch(cartApiServiceProvider);
  return cartApiService.getCartsByDateRange(
      dateRange['start']!, dateRange['end']!);
});

// Provider for user-specific carts
final userCartsProvider =
    FutureProvider.family<List<Cart>, int>((ref, userId) async {
  final cartApiService = ref.watch(cartApiServiceProvider);
  return cartApiService.getUserCarts(userId);
});
