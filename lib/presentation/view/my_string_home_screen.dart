import 'package:flutter/material.dart';
import 'package:test_flutter_dummy_mvi/data/local/my_string_shared_prefs_repository.dart';
import 'package:test_flutter_dummy_mvi/data/remote/my_string_remote_dio_repository.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/local/get_my_string_from_local_use_case.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/local/store_my_string_to_local_use_case.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/remote/get_my_string_from_remote_use_case.dart';
import 'package:test_flutter_dummy_mvi/presentation/intent/my_string_intent.dart';
import 'package:test_flutter_dummy_mvi/presentation/viewmodel/my_string_viewmodel.dart';

class MyStringHomeScreen extends StatefulWidget {
  const MyStringHomeScreen({super.key}); // Fix: Added key parameter to avoid
  // a warning about a named 'key' parameter

  @override
  MyStringHomeScreenState createState() => MyStringHomeScreenState();
}

class MyStringHomeScreenState extends State<MyStringHomeScreen> {
  late MyStringViewModel viewModel;
  late TextEditingController _controller;
  bool _isDataLoaded = false; // Ensures UI updates after data loads

  @override
  void initState() {
    super.initState();
    final sharedPrefsRepository = MyStringSharedPrefsRepository();
    final backendServerRepository = MyStringRemoteDioRepository();

    viewModel = MyStringViewModel(
      getLocalUseCase: GetMyStringFromLocalUseCase(repository: sharedPrefsRepository),
      storeLocalUseCase: StoreMyStringToLocalUseCase(repository: sharedPrefsRepository),
      getRemoteUseCase: GetMyStringFromRemoteUseCase(repository: backendServerRepository),
    );

    _controller = TextEditingController();

    // Ensure UI updates properly after data loads
    viewModel.loadInitialValue().then((_) {
      setState(() {
        _isDataLoaded = true;
        // Clear controller text for immediate use:
        _controller.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MVI Flutter App')),
      body: SingleChildScrollView(
        child: Padding(
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
                  setState(() {
                    viewModel.handleIntent(UpdateFromUserIntent(_controller.text));
                    // Clear controller text for next use:
                    _controller.clear();
                  });
                },
                child: const Text('Update from User'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    viewModel.handleIntent(UpdateFromServerIntent()).then((_) {
                      setState(() {});
                    });
                  });
                },
                child: viewModel.isLoadingDataFromRemoteServer
                    ? const CircularProgressIndicator()
                    : const Text('Update from Server'),
              ),
              const SizedBox(height: 20),
              Text('Current Value: ${viewModel.myString}', style: const TextStyle(fontSize: 18)),
            ],
          )
              : const Center(child: CircularProgressIndicator()), // Show loading only initially
        ),
      ),
    );
  }
}
