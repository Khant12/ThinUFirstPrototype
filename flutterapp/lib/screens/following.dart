import 'package:flutter/material.dart';
import 'users.dart';

class FollowingPage extends StatelessWidget {
  const FollowingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Following'),
        backgroundColor: const Color(0xFF4D4DC6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildFollowingUserCard(
                context, 'John Doe', 'johndoe@gmail.com', 'images/logo.png'),
            _buildFollowingUserCard(context, 'Jane Smith',
                'janesmith@gmail.com', 'images/logo.png'),
            // Add more user cards here
          ],
        ),
      ),
    );
  }

  void _showUserProfilePopup(
      BuildContext context, String username, String email, String avatar) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UserProfilePopup(
            username: username, email: email, avatar: avatar);
      },
    );
  }

  Widget _buildFollowingUserCard(
      BuildContext context, String username, String email, String avatar) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(avatar),
        ),
        title: Text(
          username,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          email,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        onTap: () {
          _showUserProfilePopup(context, username, email, avatar);
        },
      ),
    );
  }
}

class UserProfilePopup extends StatelessWidget {
  final String username;
  final String email;
  final String avatar;

  const UserProfilePopup({
    Key? key,
    required this.username,
    required this.email,
    required this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4D4DC6),
              ),
            ),
            const SizedBox(height: 16),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(avatar),
              radius: 50,
            ),
            const SizedBox(height: 16),
            Text(
              '$username',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              ' $email',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _navigateToUserProfile(context, username, email, avatar);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4D4DC6),
              ),
              child: const Text('View Profile',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToUserProfile(
      BuildContext context, String username, String email, String avatar) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfilePage(
          username: username,
          email: email,
        ),
      ),
    );
  }
}
