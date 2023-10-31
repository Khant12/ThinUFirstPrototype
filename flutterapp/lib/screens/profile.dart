import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/colors.dart';
import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/aboutus.dart';
import 'package:flutter_app/screens/editprofile.dart';
import 'package:flutter_app/screens/enrolled_courses.dart';
import 'package:flutter_app/screens/following.dart';
import 'package:flutter_app/screens/payment_history.dart';
import 'package:flutter_app/screens/quiz.dart';
import 'package:flutter_app/screens/settings.dart';
import 'package:flutter_app/screens/subscription.dart';
import 'package:flutter_app/services/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../constant.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user;
  bool loading = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _imageFile;
  final _picker = ImagePicker();
  TextEditingController txtNameController = TextEditingController();

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // get user detail
  void getUser() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
        loading = false;
        txtNameController.text = user!.name ?? '';
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  //update profile
  void updateProfile() async {
    ApiResponse response =
        await updateUser(txtNameController.text, getStringImage(_imageFile));
    setState(() {
      loading = false;
    });
    if (response.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.data}')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: EdgeInsets.only(top: 30, left: 30, right: 30),
            child: ListView(
              children: [
                Center(
                    child: GestureDetector(
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: tuDarkBlue),
                  ),
                )),
                SizedBox(
                  height: 18,
                ),
                _buildProfileDetails(),
                const SizedBox(height: 16),
                _buildFollowingStats(context),
                const SizedBox(height: 8),
                _buildPaymentSection(context),
                _buildSubscriptionSection(context),
                _buildEditProfileSection(context),
                _buildSettingSection(context),
                _buildAbtUsSection(context),
                _buildSignOutButton(context),
              ],
            ),
          );
  }

  Widget _buildProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Column(
          children: [
            Text(
              'username',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          '@user_id',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Account Type: Premium',
          style: TextStyle(
            fontSize: 16,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildFollowingStats(BuildContext context) {
    return Row(
      children: [
        _buildFollowingButton('Courses', '2', Colors.white, tuDarkBlue, () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const EnrolledCoursesPage()),
          );
        }),
        const SizedBox(width: 16),
        _buildFollowingButton('Following', '2', Colors.white, tuDarkBlue, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FollowingPage()),
          );
        }),
      ],
    );
  }

  Widget _buildFollowingButton(String title, String count, Color textColor,
      Color backgroundColor, Function() onPressed) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: const Size(
              double.infinity, 55.0), // Set the desired button height
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              count,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowingBox(
      String title, String count, Color textColor, Color backgroundColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildHelpandSupportSection(
      String title, IconData icon, BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuizScreen()),
          );
        },
      ),
    );
  }

  Widget _buildEditProfileSection(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.edit),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfilePage()),
          );
        },
      ),
    );
  }

  Widget _buildPaymentSection(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.history),
        title: const Text(
          'Payment History',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentHistoryPage()),
          );
        },
      ),
    );
  }

  Widget _buildSubscriptionSection(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.payment),
        title: const Text(
          'Subscription',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SubscriptionPlans()),
          );
        },
      ),
    );
  }

  Widget _buildSettingSection(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.settings),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsPage()),
          );
        },
      ),
    );
  }

  Widget _buildAbtUsSection(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.info),
        title: const Text(
          'About Us',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutUs()),
          );
        },
      ),
    );
  }

  Widget _buildSignOutButton(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: const Icon(
          Icons.exit_to_app,
          color: Colors.red,
          size: 25,
        ),
        title: const Text(
          'Sign Out',
          style: TextStyle(
            fontSize: 18,
            color: Colors.red,
          ),
        ),
        onTap: () {
          _showSignOutConfirmationDialog(context);
        },
      ),
    );
  }

  void _showSignOutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Are you sure you want to sign out?',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.success(
                            message: "Sign Out Successful!",
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
