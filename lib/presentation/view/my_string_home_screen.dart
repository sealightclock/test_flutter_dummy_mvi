import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/my_string_viewmodel.dart';

class MyStringHomeScreen extends StatelessWidget {
  const MyStringHomeScreen({super.key}); // Fix: Added key parameter

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MyStringViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Test Flutter Dummy MVI')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: viewModel.textController,
              decoration: InputDecoration(labelText: 'Enter a string'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => viewModel.updateFromUser(),
              child: Text('Update from User'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => viewModel.updateFromServer(),
              child: Text('Update from Server'),
            ),
            SizedBox(height: 20),
            Text(
              'Current Value: ${viewModel.myString}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
