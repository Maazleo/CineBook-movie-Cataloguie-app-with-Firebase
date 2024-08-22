import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;

  const ProfileScreen({
    Key? key,
    required this.username,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              backgroundImage: AssetImage('lib/images/splash.png'),
              radius: 100,
            ),
            const SizedBox(height: 10),
            Text(
              "DenkoWatcher",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "maazmasroorhuss@gmail.com",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white60,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Text(
                'Flutter developer | Netflix enthusiast | Cinephile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildFollowSection(),
            const SizedBox(height: 20),
            _buildSocialMediaLinks(),
            const SizedBox(height: 20),
            _buildEditProfileButton(),
            const SizedBox(height: 20),
            _buildInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFollowInfo('Movies', 120),
        const SizedBox(width: 40),
        _buildFollowInfo('TV Shows', 150),
      ],
    );
  }

  Widget _buildFollowInfo(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMediaLinks() {
    final List<String> socialMediaLinks = [
      'https://twitter.com/johndoe',
      'https://linkedin.com/in/johndoe',
      'https://github.com/johndoe'
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: socialMediaLinks.map((link) {
        return IconButton(
          icon: Icon(_getSocialMediaIcon(link)),
          onPressed: () {
            // Handle link navigation
          },
        );
      }).toList(),
    );
  }

  IconData _getSocialMediaIcon(String link) {
    if (link.contains('twitter')) {
      return Icons.alternate_email;
    } else if (link.contains('linkedin')) {
      return Icons.work;
    } else if (link.contains('github')) {
      return Icons.code;
    }
    return Icons.link;
  }

  Widget _buildEditProfileButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle edit profile action
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50), backgroundColor: Colors.cyan,
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: const Text('Edit Profile'),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.person, 'Username', "DenkoWatcher"),
          const SizedBox(height: 15),
          _buildInfoRow(Icons.email, 'Email', "maazmasroorhuss@gmail.com"),
          const SizedBox(height: 15),
          _buildInfoRow(Icons.location_city, 'Location', 'Pak, LHR'),
          const SizedBox(height: 15),
          _buildInfoRow(Icons.calendar_today, 'Member Since', 'January 2023'),
          const SizedBox(height: 15),
          _buildInfoRow(Icons.favorite, 'Interests', 'Movies, TV Shows, Coding'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.cyan),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
