import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  DateTime? selectedDate;

  final Color primaryColor = const Color(0xFF4D4DC6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor, // Set the app bar color
        title:
            const Text('Edit Profile', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // User Profile Picture
            Center(
              child: Stack(
                children: <Widget>[
                  const CircleAvatar(
                    radius: 70.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                        'images/logo.png'), // Replace with user's profile image
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Handle profile picture upload or change
                      },
                      backgroundColor: primaryColor, // Set the button color
                      child: const Icon(Icons.camera_alt,
                          color: Colors.white), // Set the icon color
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Name Field
            const Text('Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                icon: Icon(Icons.person,
                    color: primaryColor), // Set the icon color
              ),
            ),
            const SizedBox(height: 20),
            // Email Field
            const Text('Email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                icon: Icon(Icons.email,
                    color: primaryColor), // Set the icon color
              ),
            ),
            const SizedBox(height: 20),
            const Text('Date of Birth',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: <Widget>[
                Text(
                  selectedDate == null
                      ? 'Select your birthdate'
                      : DateFormat('dd/MM/yyyy').format(selectedDate!),
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () => _selectDate(context),
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  label: const Text('Pick Date',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Save Changes Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(context);
                },
                child: const Text('Save Changes',
                    style:
                        TextStyle(color: Colors.white)), // Set the text color
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      primaryColor, // Set the button background color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Profile Updated'),
          content: const Text('Your profile has been updated successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Navigate back to the previous page
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
