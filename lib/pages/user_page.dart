import 'package:ebuy/vintage_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/user_model.dart';
import '../provider/user_provider.dart';

class UserPage extends ConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = 1; // Set the current user ID

    // Fetch user details using userByIdProvider
    final userProvider = ref.watch(userByIdProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: userProvider.when(
        data: (user) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?u=${user.id}'), // Random user avatar
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${user.name.firstname} ${user.name.lastname}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Personal Information
                _buildSectionTitle('Personal Information'),
                _buildProfileRow('Email', user.email),
                _buildProfileRow('Phone', user.phone),
                const SizedBox(height: 20),

                // Address Information
                _buildSectionTitle('Address'),
                _buildProfileRow(
                    'Street', '${user.address.street}, ${user.address.number}'),
                _buildProfileRow('City', user.address.city),
                _buildProfileRow('Zipcode', user.address.zipcode),
                const SizedBox(height: 20),

                // Geolocation
                _buildSectionTitle('Geolocation'),
                _buildProfileRow('Latitude', user.address.geolocation.lat),
                _buildProfileRow('Longitude', user.address.geolocation.long),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  // Widget to build section title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: VintageTheme.onBackgroundColor,
        ),
      ),
    );
  }

  // Widget to build each profile row
  Widget _buildProfileRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.brown,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
