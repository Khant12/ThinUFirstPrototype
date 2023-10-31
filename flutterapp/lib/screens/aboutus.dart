import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D4DC6),
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'images/logo.png',
                  height: 100,
                ),
              ),
              const SizedBox(height: 24), // Increased spacing
              const Center(
                child: Text(
                  'Welcome to ThinU',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4D4DC6),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('About Us:'),
              _buildSectionContent(
                'We are a team of innovative minds dedicated to creating exceptional Flutter applications. '
                'Our mission is to craft cutting-edge, user-centric solutions that elevate the user experience.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Our Core Values:'),
              _buildSectionContentDetails(
                1,
                'Innovation: We thrive on pushing the boundaries of what\'s possible in mobile app development.\n',
                2,
                'User-Centric: Our users are at the heart of everything we do, and we prioritize their needs and preferences.\n',
                3,
                'Quality: We are committed to delivering high-quality, bug-free applications.\n',
                4,
                'Collaboration: Teamwork is key, and we value open communication and collaboration.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Contact Us:'),
              _buildContactInfo(Icons.email, 'Email', 'tinu@gmail.com'),
              _buildContactInfo(Icons.phone, 'Phone', '+959 914 567 890'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16), // Increased padding
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4D4DC6),
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16), // Increased padding
      child: RichText(
        textAlign: TextAlign.justify, // Justify the text
        text: TextSpan(
          style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              height: 1), // Adjust line spacing
          children: <TextSpan>[
            TextSpan(
              text: content,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionContentDetails(
    int number1,
    String content1,
    int number2,
    String content2,
    int number3,
    String content3,
    int number4,
    String content4,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16), // Increased padding
      child: RichText(
        textAlign: TextAlign.justify, // Justify the text
        text: TextSpan(
          style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              height: 1), // Adjust line spacing
          children: <TextSpan>[
            TextSpan(
              text: '$number1. $content1\n',
            ),
            TextSpan(
              text: '$number2. $content2\n',
            ),
            TextSpan(
              text: '$number3. $content3\n',
            ),
            TextSpan(
              text: '$number4. $content4',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 0), // Remove horizontal padding
      leading: Icon(icon, color: const Color(0xFF4D4DC6)),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}
