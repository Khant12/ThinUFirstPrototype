import 'package:flutter/material.dart';
import 'package:flutter_app/components/colors.dart';

class CourseCreate extends StatefulWidget {
  final Function(String) onCourseCreated;

  const CourseCreate({Key? key, required this.onCourseCreated})
      : super(key: key);

  @override
  State<CourseCreate> createState() => _CourseCreateState();
}

class _CourseCreateState extends State<CourseCreate> {
  final TextEditingController _coursetitleController = TextEditingController();
  final TextEditingController _coursesubtitleController =
      TextEditingController();
  final TextEditingController _coursedescricptionController =
      TextEditingController();
  final TextEditingController _whatuwilllearnController =
      TextEditingController();
  final TextEditingController _thiscourseincludesController =
      TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();
  String username = "Khant Si Thu";

  Widget _buildImageCard() {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {}, // Trigger the image picker when tapped
        child: Container(
          height: 150,
          width: 300,
          child: const Icon(
            Icons.videocam,
            size: 40,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tuDarkBlue,
        title: Text('Create A Course'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(40, 10, 5, 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: tuLightBlue,
                minimumSize: Size(70, 40), // Change to your desired color
              ),
              onPressed: () async {
                // Get the value of the "Course Title" text field
                String courseTitle = _coursetitleController.text;

                // Call the callback to update the dropdownItems list
                widget.onCourseCreated(courseTitle);

                // Clear the text fields
                _coursetitleController.text = '';
                _coursesubtitleController.text = '';
                _coursedescricptionController.text = '';
                _whatuwilllearnController.text = '';
                _thiscourseincludesController.text = '';
                _requirementsController.text = '';
                // _selectedImage = null;

                // Close the bottom sheet
                Navigator.of(context).pop();
              },
              child: Text('Create'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 15,
            right: 15,
            // this will prevent the soft keyboard from covering the text fields
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.lightBlue,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username, // Always set username as poster
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Information About the Course',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Apply bold font weight
                  fontSize: 18, // Set the font size to 18
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors
                      .white60, // Set the background color of the container
                  border:
                      Border.all(color: tuDarkBlue, width: 1), // Add a border
                  borderRadius: BorderRadius.circular(5), // Add rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      TextField(
                        controller: _coursetitleController,
                        decoration:
                            const InputDecoration(hintText: 'Course Title'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _coursesubtitleController,
                        decoration: const InputDecoration(
                            hintText: 'A short Sub-title'),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: _coursedescricptionController,
                        decoration:
                            const InputDecoration(hintText: 'Description'),
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'What viewers will learn from this Course?',
                textAlign: TextAlign.left, // Align text to the left
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Apply bold font weight
                  fontSize: 18, // Set the font size to 18
                ),
              ),
              TextField(
                controller: _whatuwilllearnController,
                decoration:
                    const InputDecoration(hintText: 'Viewers will Learn....'),
                maxLines: 3,
              ),
              const SizedBox(height: 40),
              Text(
                'What contents will this Course include?',
                textAlign: TextAlign.left, // Align text to the left
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Apply bold font weight
                  fontSize: 18, // Set the font size to 18
                ),
              ),
              TextField(
                controller: _thiscourseincludesController,
                decoration:
                    const InputDecoration(hintText: 'This Course Includes....'),
                maxLines: 3,
              ),
              const SizedBox(height: 40),
              Text(
                'Requirements needed for the viewers to understand this course',
                textAlign: TextAlign.left, // Align text to the left
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Apply bold font weight
                  fontSize: 18, // Set the font size to 18
                ),
              ),
              TextField(
                controller: _requirementsController,
                decoration:
                    const InputDecoration(hintText: 'Viewers will Require....'),
                maxLines: 3,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
