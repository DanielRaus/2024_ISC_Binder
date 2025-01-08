// lib/screens/user_profile_screen.dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/profile_section.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample user data
    final user = User(
      name: 'John Doe',
      favoriteGenres: ['Fiction', 'Mystery', 'Science Fiction', 'Biography'],
      preferredLanguages: ['English', 'French'],
      profileImagePath: 'assets/images/profile.jpg',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
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
                    backgroundImage: AssetImage(user.profileImagePath),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Favorite Genres
            ProfileSection(
              title: 'Favorite Genres',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: user.favoriteGenres.map((genre) {
                  return Chip(
                    label: Text(genre),
                    backgroundColor: Colors.blue[100],
                  );
                }).toList(),
              ),
            ),

            // Preferred Languages
            ProfileSection(
              title: 'Preferred Languages',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: user.preferredLanguages.map((language) {
                  return Chip(
                    label: Text(language),
                    backgroundColor: Colors.green[100],
                  );
                }).toList(),
              ),
            ),

            // Reading Preferences
            ProfileSection(
              title: 'Reading Preferences',
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Notify about new matches'),
                    value: true,
                    onChanged: (bool value) {},
                  ),
                  SwitchListTile(
                    title: const Text('Show only available books'),
                    value: true,
                    onChanged: (bool value) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}