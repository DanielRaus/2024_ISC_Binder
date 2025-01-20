import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Sample preferences data
  final Map<String, List<String>> _preferences = {
    'Genres': [
      'Fiction',
      'Non-Fiction',
      'Mystery',
      'Science Fiction',
      'Fantasy',
      'Romance',
      'Historical',
      'Biography',
      'Self-Help',
      'Poetry',
    ],
    'Languages': [
      'English',
      'Spanish',
      'French',
      'German',
      'Italian',
      'Japanese',
      'Chinese',
    ],
    'Reading Level': [
      'Beginner',
      'Intermediate',
      'Advanced',
      'Academic',
    ],
    'Book Length': [
      'Short (< 200 pages)',
      'Medium (200-400 pages)',
      'Long (> 400 pages)',
    ],
  };

  final Map<String, Set<String>> _selectedPreferences = {
    'Genres': {'Fiction', 'Mystery'},
    'Languages': {'English'},
    'Reading Level': {'Intermediate'},
    'Book Length': {'Medium (200-400 pages)'},
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Picture and Username
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tester',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),

          // Preferences Sections
          ..._preferences.entries.map((entry) => _buildPreferenceSection(
            title: entry.key,
            options: entry.value,
            selectedOptions: _selectedPreferences[entry.key]!,
          )),
        ],
      ),
    );
  }

  Widget _buildPreferenceSection({
    required String title,
    required List<String> options,
    required Set<String> selectedOptions,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        width: double.infinity, // Makes all cards same width
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: options.map((option) => FilterChip(
                label: Text(option),
                selected: selectedOptions.contains(option),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedOptions.add(option);
                    } else {
                      selectedOptions.remove(option);
                    }
                  });
                },
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}