import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/cart_model.dart';

class CartApiService {
  static const String baseUrl = 'https://fakestoreapi.com/carts';

  // Fetch all carts
  Future<List<Cart>> getAllCarts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((cart) => Cart.fromJson(cart)).toList();
    } else {
      throw Exception('Failed to load carts');
    }
  }

  // Fetch a single cart by ID
  Future<Cart> getCartById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Cart.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load cart');
    }
  }

  // Fetch limited carts
  Future<List<Cart>> getLimitedCarts(int limit) async {
    final response = await http.get(Uri.parse('$baseUrl?limit=$limit'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((cart) => Cart.fromJson(cart)).toList();
    } else {
      throw Exception('Failed to load carts');
    }
  }

  // Fetch sorted carts
  Future<List<Cart>> getSortedCarts(String sort) async {
    final response = await http.get(Uri.parse('$baseUrl?sort=$sort'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((cart) => Cart.fromJson(cart)).toList();
    } else {
      throw Exception('Failed to load carts');
    }
  }

  // Fetch carts in date range
  Future<List<Cart>> getCartsByDateRange(
      String startDate, String endDate) async {
    final response = await http
        .get(Uri.parse('$baseUrl?startdate=$startDate&enddate=$endDate'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((cart) => Cart.fromJson(cart)).toList();
    } else {
      throw Exception('Failed to load carts');
    }
  }

  // Fetch cart for a specific user
  Future<List<Cart>> getUserCarts(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/$userId'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((cart) => Cart.fromJson(cart)).toList();
    } else {
      throw Exception('Failed to load user carts');
    }
  }

  // Add a new cart
  Future<Cart> addCart(Cart cart) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cart.toJson()),
    );
    if (response.statusCode == 200) {
      return Cart.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add cart');
    }
  }

  // Update an existing cart
  Future<Cart> updateCart(int id, Cart cart) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cart.toJson()),
    );
    if (response.statusCode == 200) {
      return Cart.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update cart');
    }
  }

  // Delete a cart
  Future<void> deleteCart(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete cart');
    }
  }
}
