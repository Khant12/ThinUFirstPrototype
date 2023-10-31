import 'package:flutter/material.dart';
import 'package:flutter_app/components/colors.dart';
import 'package:flutter_app/screens/courses.dart';
import 'package:flutter_app/screens/post_form.dart';
import 'package:flutter_app/screens/post_screen.dart';

import 'profile.dart';
import 'search.dart';
import 'notifications.dart';
import 'subscription.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    PostScreen(),
    CourseListScreen(),
    SearchPage(),
    PostScreen(),
    Profile(),
  ];
  String username = 'Richard';
  String email = 'thureinrichard3@gmail.com';
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            // Add your logo image here
            Image.asset(
              'images/logo.png', // Replace with the path to your logo image
              width: 40, // Adjust the width as needed
              height: 40, // Adjust the height as needed
            ),
            const SizedBox(
                width: 8), // Add some spacing between the logo and title
            const Text(
              'Thin U', // Title text
              style: TextStyle(
                  fontSize: 18, // Adjust the font size as needed
                  color: Colors.black),
            ),
          ],
        ),
        actions: [
          // Add a notification icon button here
          IconButton(
            icon: Icon(Icons.notifications),
            color: tuDarkBlue,
            iconSize: 32,
            onPressed: () {
              // Navigate to the notifications.dart page when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationsPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.diamond_outlined),
            color: tuDarkBlue,
            iconSize: 32,
            onPressed: () {
              // Navigate to the notifications.dart page when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubscriptionPlans(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PostForm(
                    title: 'Add new post',
                  )));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_rounded),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max_rounded),
            label: 'Watched List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: tuDarkBlue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
