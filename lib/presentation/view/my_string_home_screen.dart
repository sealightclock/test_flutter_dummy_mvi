import 'package:flutter/material.dart';
import '../../domain/data/local/my_string_shared_prefs_repository.dart';
import '../../domain/data/remote/my_string_backend_server_repository.dart';
import '../../domain/usecase/local/get_my_string_from_shared_prefs_use_case.dart';
import '../../domain/usecase/local/store_my_string_to_shared_prefs_use_case.dart';
import '../../domain/usecase/remote/get_my_string_from_backend_server_use_case.dart';
import '../intent/my_string_intent.dart';
import '../viewmodel/my_string_viewmodel.dart';

class MyStringHomeScreen extends StatefulWidget {
  const MyStringHomeScreen({super.key}); // Fix: Added key parameter

  @override
  _MyStringHomeScreenState createState() => _MyStringHomeScreenState();
}

class _MyStringHomeScreenState extends State<MyStringHomeScreen> {
  late MyStringViewModel viewModel;
  late TextEditingController _controller;

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
    viewModel.loadInitialValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MVI Flutter App')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter value'),
            ),
            ElevatedButton(
              onPressed: () {
                viewModel.handleIntent(UpdateFromUserIntent(_controller.text));
              },
              child: Text('Update from User'),
            ),
            ElevatedButton(
              onPressed: () {
                viewModel.handleIntent(UpdateFromServerIntent());
              },
              child: viewModel.isLoading ? CircularProgressIndicator() : Text('Update from Server'),
            ),
            SizedBox(height: 20),
            Text('Stored Value: ${viewModel.myString}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
