import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/user_model.dart';
import '../service/user_api_service.dart';

// User API service provider
final userApiServiceProvider = Provider<UserApiService>((ref) {
  return UserApiService();
});

// Provider for all users
final allUsersProvider = FutureProvider<List<User>>((ref) async {
  final userApiService = ref.watch(userApiServiceProvider);
  return userApiService.getAllUsers();
});

// Provider for a single user by ID
final userByIdProvider = FutureProvider.family<User, int>((ref, id) async {
  final userApiService = ref.watch(userApiServiceProvider);
  return userApiService.getUserById(id);
});

// Provider for limited users
final limitedUsersProvider =
    FutureProvider.family<List<User>, int>((ref, limit) async {
  final userApiService = ref.watch(userApiServiceProvider);
  return userApiService.getLimitedUsers(limit);
});

// Provider for sorted users
final sortedUsersProvider =
    FutureProvider.family<List<User>, String>((ref, sort) async {
  final userApiService = ref.watch(userApiServiceProvider);
  return userApiService.getSortedUsers(sort);
});

// Provider for adding a user
final addUserProvider = FutureProvider.family<User, User>((ref, user) async {
  final userApiService = ref.watch(userApiServiceProvider);
  return userApiService.addUser(user);
});

// Provider for updating a user
final updateUserProvider =
    FutureProvider.family<User, Map<String, dynamic>>((ref, params) async {
  final userApiService = ref.watch(userApiServiceProvider);
  int id = params['id'];
  User user = params['user'];
  return userApiService.updateUser(id, user);
});

// Provider for deleting a user
final deleteUserProvider = FutureProvider.family<void, int>((ref, id) async {
  final userApiService = ref.watch(userApiServiceProvider);
  return userApiService.deleteUser(id);
});

// Provider for logging in a user
final loginUserProvider = FutureProvider.family<AuthToken, Map<String, String>>(
    (ref, credentials) async {
  final userApiService = ref.watch(userApiServiceProvider);
  String username = credentials['username']!;
  String password = credentials['password']!;
  return userApiService.loginUser(username, password);
});
