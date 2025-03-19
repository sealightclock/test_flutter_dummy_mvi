import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_flutter_dummy_mvi/util/my_string_constants.dart';

import 'presentation/view/my_string_home_screen.dart';

Future<void> main() async {
  // Initialize Hive
  await Hive.initFlutter();
  // Open the box before using it
  await Hive.openBox<String>(hiveBoxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Fix: Added key parameter to avoid
  // a warning about a named 'key' parameter

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Flutter Dummy MVI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyStringHomeScreen(),
    );
  }
}
