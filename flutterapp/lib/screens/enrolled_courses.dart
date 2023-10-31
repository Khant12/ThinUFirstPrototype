import 'package:flutter/material.dart';

class EnrolledCoursesPage extends StatelessWidget {
  const EnrolledCoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D4DC6),
        title: const Text('Enrolled Courses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCourseCard(
              context,
              'Course 1: Introduction to Flutter',
              'Instructor: John Doe',
              'Duration: 4 weeks',
            ),
            _buildCourseCard(
              context,
              'Course 2: Advanced Dart Programming',
              'Instructor: Jane Smith',
              'Duration: 6 weeks',
            ),
            // Add more course cards as needed
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(
      BuildContext context, String title, String instructor, String duration) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.book, size: 48, color: Color(0xFF4D4DC6)),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              instructor,
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              duration,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward, color: Color(0xFF4D4DC6)),
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => CourseDetailScreen(),
          //   ),
          // );
        },
      ),
    );
  }
}
