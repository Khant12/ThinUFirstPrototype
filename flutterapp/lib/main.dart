import 'package:flutter/material.dart';

import 'screens/loading.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xffeeeeee)),
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}
