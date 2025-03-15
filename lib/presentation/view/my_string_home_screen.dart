import 'package:flutter/material.dart';
import 'package:test_flutter_dummy_mvi/data/local/my_string_shared_prefs_repository.dart';
import 'package:test_flutter_dummy_mvi/data/remote/my_string_backend_server_repository.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/local/get_my_string_from_shared_prefs_use_case.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/local/store_my_string_to_shared_prefs_use_case.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/remote/get_my_string_from_backend_server_use_case.dart';
import 'package:test_flutter_dummy_mvi/presentation/intent/my_string_intent.dart';
import 'package:test_flutter_dummy_mvi/presentation/viewmodel/my_string_viewmodel.dart';

class MyStringHomeScreen extends StatefulWidget {
  const MyStringHomeScreen({super.key}); // Fix: Added key parameter

  @override
  MyStringHomeScreenState createState() => MyStringHomeScreenState();
}

class MyStringHomeScreenState extends State<MyStringHomeScreen> {
  late MyStringViewModel viewModel;
  late TextEditingController _controller;
  bool _isDataLoaded = false; // ✅ Ensures UI updates after data loads

  @override
  void initState() {
    super.initState();
    final sharedPrefsRepository = MyStringSharedPrefsRepository();
    final backendServerRepository = MyStringBackendServerRepository();

    viewModel = MyStringViewModel(
      getLocalUseCase: GetMyStringFromSharedPrefsUseCase(repository: sharedPrefsRepository),
      storeLocalUseCase: StoreMyStringToSharedPrefsUseCase(repository: sharedPrefsRepository),
      getRemoteUseCase: GetMyStringFromBackendServerUseCase(repository: backendServerRepository),
    );

    _controller = TextEditingController();

    // ✅ Ensure UI updates properly after data loads
    viewModel.loadInitialValue().then((_) {
      setState(() {
        _isDataLoaded = true;
        _controller.text = viewModel.myString; // ✅ Pre-fill text field with stored value
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MVI Flutter App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isDataLoaded
            ? Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter value'),
            ),
            ElevatedButton(
              onPressed: () {
                viewModel.handleIntent(UpdateFromUserIntent(_controller.text));
              },
              child: const Text('Update from User'),
            ),
            ElevatedButton(
              onPressed: () {
                viewModel.handleIntent(UpdateFromServerIntent());
              },
              child: viewModel.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Update from Server'),
            ),
            const SizedBox(height: 20),
            Text('Stored Value: ${viewModel.myString}', style: const TextStyle(fontSize: 18)),
          ],
        )
            : const Center(child: CircularProgressIndicator()), // ✅ Show loading only initially
      ),
    );
  }
}
