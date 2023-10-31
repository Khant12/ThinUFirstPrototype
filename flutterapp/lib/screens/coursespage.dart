// ------------------------ Lesson details -----------
//----------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_app/components/colors.dart';
import 'package:flutter_app/screens/quiz.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key}) : super(key: key);
  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    int itemCount = 5; // Total number of sections, including quizzes
    List<Widget> sectionWidgets = [];

    for (int i = 1; i <= itemCount; i++) {
      sectionWidgets.add(
        ListTile(
          title: Text('Section $i'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Examples(sectionIndex: i),
              ),
            );
          },
          trailing: Icon(
            Icons.remove_red_eye,
            color: Colors.green,
            size: 20,
          ),
        ),
      );

      // Add a quiz after every 2 sections
      if (i % 2 == 0 && i < itemCount) {
        sectionWidgets.add(ListTile(
          title: Text('Quiz'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizScreen(),
              ),
            );
          },
          trailing: Icon(
            Icons.school,
            color: Colors.blue,
            size: 20,
          ),
        ));
      }
    }

    return Scaffold(
      body: ListView(
        children: sectionWidgets,
      ),
    );
  }
}

//----------------------- default video player
//-----------------------------

class Examples extends StatefulWidget {
  const Examples({Key? key, required int sectionIndex}) : super(key: key);

  @override
  _ExamplesState createState() => _ExamplesState();
}

class _ExamplesState extends State<Examples> {
  // final List<Map<String, dynamic>> samples = [
  //   {'name': 'Default player', 'widget': DefaultPlayer()},
  // ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Wrap your widget tree with MaterialApp
      home: Scaffold(
        appBar: AppBar(
          title: Text('Video'),
          backgroundColor: tuDarkBlue,
        ),
        body: _buildWebView(),
      ),
    );
  }

  Widget _buildWebView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close), // Add your close icon here
              onPressed: () {
                // Navigate back to the main page
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            // child: WebVideoPlayer(),
          ),
        ),
      ],
    );
  }

  // Widget _buildMobileView() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[],
  //   );
  // }
}
