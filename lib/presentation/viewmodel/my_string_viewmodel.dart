import 'package:flutter/material.dart';
import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/local/get_my_string_from_shared_prefs_use_case.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/local/store_my_string_to_shared_prefs_use_case.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/remote/get_my_string_from_backend_server_use_case.dart';
import 'package:test_flutter_dummy_mvi/presentation/intent/my_string_intent.dart';

class MyStringViewModel with ChangeNotifier {
  // A ViewModel should deal with only Use Cases, not their Repositories.
  final GetMyStringFromSharedPrefsUseCase getLocalUseCase;
  final StoreMyStringToSharedPrefsUseCase storeLocalUseCase;
  final GetMyStringFromBackendServerUseCase getRemoteUseCase;

  // This is the single data to be handled by the ViewModel.
  // In MVI, data cannot be directly modified by outside code. They can be modified indirectly via Intent.
  // So we only need "myStrong" but not "_myString".
  String myString = 'Default Value from ViewModel'; // Kept for debugging

  // Flags for UI synchronization:
  bool isLoadingDataFromRemoteServer = false;

  // Constructor:
  MyStringViewModel({
    required this.getLocalUseCase,
    required this.storeLocalUseCase,
    required this.getRemoteUseCase,
  });

  // This function handles intents sent from the View:
  Future<void> handleIntent(MyStringIntent intent) async {
    if (intent is UpdateFromUserIntent) {
      // This will trigger a widget rebuild due to a mechanism ...
      myString = intent.newValue;
      // Update local storage:
      await storeLocalUseCase.execute(myString);
      // Recommended: notify other listeners:
      notifyListeners();
    } else if (intent is UpdateFromServerIntent) {
      isLoadingDataFromRemoteServer = true;
      notifyListeners(); // This is needed so that the View can display the circular progress indicator.
      MyStringEntity newValue = await getRemoteUseCase.execute();
      myString = newValue.value;
      await storeLocalUseCase.execute(myString);
      isLoadingDataFromRemoteServer = false;
      notifyListeners();
    }
  }

  Future<void> loadInitialValue() async {
    MyStringEntity storedEntity = await getLocalUseCase.execute();
    myString = storedEntity.value;
    notifyListeners();
  }
}
