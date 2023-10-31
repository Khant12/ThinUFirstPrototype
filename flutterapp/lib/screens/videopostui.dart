import 'package:flutter/material.dart';
import 'package:flutter_app/components/colors.dart';
import 'courseCreateUI.dart';

class videopost extends StatefulWidget {
  const videopost({super.key});

  @override
  State<videopost> createState() => _videopostState();
}

class _videopostState extends State<videopost> {
  final TextEditingController _videotitleController = TextEditingController();
  final TextEditingController _videodescriptionController =
      TextEditingController();
  String username = "Khant Si Thu";

  List<String> dropdownItems = ["Basic Website Development", "Create New"];

  void handleCourseCreated(String courseTitle) {
    setState(() {
      dropdownItems.insert(dropdownItems.length - 1, courseTitle);
    });
  }

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
        title: Text('Post A Video'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30, 10, 5, 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: tuLightBlue,
                minimumSize: Size(80, 40), // Change to your desired color
              ),
              onPressed: () async {
                // Clear the text fields
                _videotitleController.text = '';
                _videodescriptionController.text = '';
                // _selectedImage = null;

                // Close the bottom sheet
                Navigator.of(context).pop();
              },
              child: Text('Post'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 20,
              right: 25,
              // this will prevent the soft keyboard from covering the text fields
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
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
                  height: 10,
                ),
                Container(
                  child: CustomDropdown(
                    dropdownItems: dropdownItems,
                    onCourseCreate: () {
                      // Navigate to the "Create New" page.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseCreate(
                              onCourseCreated: handleCourseCreated),
                        ),
                      );
                    },
                  ),
                ),

                // const SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   child: NewAlbumWidget(),
                // ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _videotitleController,
                  decoration: const InputDecoration(hintText: 'Video Title'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _videodescriptionController,
                  decoration: const InputDecoration(hintText: 'Descriptions'),
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: _buildImageCard(),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class NewAlbumWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  size: 48,
                  color: Colors.blue,
                ),
                SizedBox(width: 16),
                Text(
                  'Create New Album',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
            color: Colors.grey,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final List<String> dropdownItems;
  final Function() onCourseCreate;

  CustomDropdown({required this.dropdownItems, required this.onCourseCreate});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String selectedValue =
      "Select a Course to add to"; // Initialize with the default value.
  bool isDropdownOpen = false;

  double calculateDropdownHeight() {
    // Calculate the maximum height based on the number of items
    double maxHeight = widget.dropdownItems.length *
        50; // Assuming each item is 50 pixels high
    // Cap the height at a maximum value of 50
    return maxHeight > 210.0 ? 210.0 : maxHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isDropdownOpen = !isDropdownOpen;
              });
            },
            child: Container(
              width: 400, // Set a fixed width for the dropdown.
              height: 50,
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                border: Border.all(color: tuLightBlue, width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(selectedValue),
                  Icon(Icons.arrow_drop_down), // Add a down arrow icon
                ],
              ),
            ),
          ),
          if (isDropdownOpen)
            Container(
              width: 400, // Set a fixed width for the dropdown.
              height:
                  calculateDropdownHeight(), // Set a fixed height for the dropdown.
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.builder(
                itemCount: widget.dropdownItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.dropdownItems[index]),
                    onTap: () {
                      if (widget.dropdownItems[index] != "Create New") {
                        setState(() {
                          selectedValue = widget.dropdownItems[index];
                          isDropdownOpen = false;
                        });
                      } else {
                        // Navigate to the "Create New" page by calling the callback.
                        widget.onCourseCreate();
                      }
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
