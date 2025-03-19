import 'package:flutter/material.dart';
import 'package:test_flutter_dummy_mvi/data/local/my_string_hive_repository.dart';
import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/local/get_my_string_from_local_use_case.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/local/store_my_string_to_local_use_case.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/remote/get_my_string_from_remote_use_case.dart';
import 'package:test_flutter_dummy_mvi/presentation/intent/my_string_intent.dart';

import '../../data/local/my_string_local_repository.dart';
import '../../data/local/my_string_shared_prefs_repository.dart';

final localStoreType = LocalStore.sharedPrefs; // !!! Change this if needed.

/// ViewModel handling UI state and business logic.
/// Notifies listeners when data changes.
class MyStringViewModel with ChangeNotifier {
  // A ViewModel should deal with only Use Cases, not their Repositories.
  GetMyStringFromLocalUseCase getLocalUseCase = GetMyStringFromLocalUseCase(
    sharedPrefsRepository: MyStringSharedPrefsRepository(),
    hiveRepository: MyStringHiveRepository(),
    storeType: localStoreType,
  ) ;
  StoreMyStringToLocalUseCase storeLocalUseCase = StoreMyStringToLocalUseCase(
    sharedPrefsRepository: MyStringSharedPrefsRepository(),
    hiveRepository: MyStringHiveRepository(),
    storeType: localStoreType,
  ) ;
  final GetMyStringFromRemoteUseCase getRemoteUseCase;

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

  /// Handles user intents and updates state accordingly.
  Future<void> handleIntent(MyStringIntent intent) async {
    if (intent is UpdateFromUserIntent) {
      // This will trigger a widget rebuild due to a mechanism ...
      myString = intent.newValue;
      // Update local storage:
      await storeLocalUseCase.execute(MyStringEntity(myString));
      // Recommended: notify other listeners:
      notifyListeners();
    } else if (intent is UpdateFromServerIntent) {
      isLoadingDataFromRemoteServer = true;
      notifyListeners();
      try {
        MyStringEntity newValue = await getRemoteUseCase.execute();
        myString = newValue.value;
        await storeLocalUseCase.execute(MyStringEntity(myString));
      } catch (e) {
        myString = "Error: Unable to fetch data";
      } finally {
        isLoadingDataFromRemoteServer = false;
        notifyListeners();
      }
    }
  }

  /// Loads the initially stored value from SharedPreferences.
  Future<void> loadInitialValue() async {
    MyStringEntity storedEntity = await getLocalUseCase.execute();
    myString = storedEntity.value;
    notifyListeners();
  }
}
