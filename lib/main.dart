import 'package:flutter/material.dart';

import 'presentation/view/my_string_home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Fix: Added key parameter

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStringHomeScreen(),
    );
  }
}
