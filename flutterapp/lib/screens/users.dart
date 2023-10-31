import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final String username;
  final String email;

  const UserProfilePage({
    Key? key,
    required this.username,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: const Color(0xFF4D4DC6),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/profile_picture.jpg'), // Replace with the path to your profile picture
            ),
            SizedBox(height: 20),
            Text(
              'John Doe', // Replace with the user's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'john.doe@example.com', // Replace with the user's email
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to edit profile
                // Navigate to edit profile page or show a modal for editing
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
