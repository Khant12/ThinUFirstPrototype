import 'package:flutter/material.dart';
import 'notifications.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D4DC6),
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Account Settings'),
            _buildAccountSettingsList(context),
            const SizedBox(height: 24),
            _buildSectionTitle('App Settings'),
            _buildAppSettingsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAccountSettingsList(BuildContext context) {
    return Column(
      children: [
        _buildListTile(
          context,
          title: 'Change Password',
          icon: Icons.lock,
          onTap: () {
            // Handle change password action
          },
        ),
        _buildListTile(
          context,
          title: 'Privacy Settings',
          icon: Icons.security,
          onTap: () {
            // Handle privacy settings action
          },
        ),
        _buildListTile(
          context,
          title: 'Two-Factor Authentication',
          icon: Icons.verified_user,
          onTap: () {
            // Handle two-factor authentication settings
          },
        ),
      ],
    );
  }

  Widget _buildAppSettingsList(BuildContext context) {
    return Column(
      children: [
        _buildListTile(
          context,
          title: 'Notifications',
          icon: Icons.notifications,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NotificationsPage()),
            );
          },
        ),
        _buildListTile(
          context,
          title: 'Language',
          icon: Icons.language,
          onTap: () {
            // Handle language settings action
          },
        ),
        _buildListTile(
          context,
          title: 'Theme',
          icon: Icons.color_lens,
          onTap: () {
            // Handle theme selection
          },
        ),
        _buildListTile(
          context,
          title: 'App Version',
          icon: Icons.info,
          onTap: () {
            // Show app version information
          },
        ),
      ],
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
        trailing: Icon(Icons.navigate_next),
        onTap: onTap,
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Thin U',
    home: SettingsPage(),
  ));
}
