import 'package:flutter/material.dart';
import 'package:flutter_app/components/colors.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<String> categories = [
    'Java',
    'Website Development',
    'C++',
    'Python',
    'Graphic Design',
    'Arts',
    'Mobile Development',
    'UI/UX',
    'Music',
    'Business',
    'Laravel',
    'Marketing'
  ];

  void _onSearchTextChanged(String query) {
    _searchQuery = query;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildSearchBar(),
                  ),
                  SizedBox(
                      width:
                          10.0), // Add some spacing between search bar and button
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Search'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          tuDarkBlue), // Change the button color to orange
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(60, 45)), // Change the button size
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.0),
              // Add your search result content here based on _searchQuery
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryRow(categories.sublist(0, 3), context),
                  _buildCategoryRow(categories.sublist(3, 6), context),
                  _buildCategoryRow(categories.sublist(6, 9), context),
                  _buildCategoryRow(categories.sublist(9, 12), context),
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  const Text(
                    'Hot Searches',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5),
              Container(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Replace with the actual number of courses
                  itemBuilder: (BuildContext context, int index) {
                    int indexplus = index + 1;
                    // return CourseCard(
                    //   courseTitle: 'Course $indexplus',
                    //   authorName: 'Author Name',
                    //   imageAssetPath: 'images/CourseIntro$index.jpg',
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        focusColor: tuDarkBlue,
        hintText: 'Search...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onChanged: _onSearchTextChanged,
    );
  }

  Widget _buildCategoryRow(List<String> categoryList, BuildContext context) {
    return Row(
      children: categoryList.map((category) {
        return Container(
          margin: EdgeInsets.only(right: 10),
          child: ElevatedButton(
            onPressed: () {
              // Handle category selection by navigating to CategoryPage
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => CategoryPage(category: category),
              //   ),
              // );
            },
            child: Text(category),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  tuLightBlue), // Replace with your color
            ),
          ),
        );
      }).toList(),
    );
  }
}
