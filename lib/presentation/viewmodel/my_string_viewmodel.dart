import 'package:flutter/material.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/local/get_my_string_from_shared_prefs_use_case.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/local/store_my_string_to_shared_prefs_use_case.dart';
import 'package:test_flutter_dummy_mvi/domain/usecase/remote/get_my_string_from_backend_server_use_case.dart';
import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';
import 'package:test_flutter_dummy_mvi/presentation/intent/my_string_intent.dart';

class MyStringViewModel with ChangeNotifier {
  final GetMyStringFromSharedPrefsUseCase getLocalUseCase;
  final StoreMyStringToSharedPrefsUseCase storeLocalUseCase;
  final GetMyStringFromBackendServerUseCase getRemoteUseCase;

  String myString = 'Default Value from ViewModel'; // Kept for debugging
  bool isLoading = false;
  bool isLoadingData = true; // ✅ Added flag for UI synchronization

  MyStringViewModel({
    required this.getLocalUseCase,
    required this.storeLocalUseCase,
    required this.getRemoteUseCase,
  });

  Future<void> handleIntent(MyStringIntent intent) async {
    if (intent is UpdateFromUserIntent) {
      myString = intent.newValue;
      await storeLocalUseCase.execute(myString);
      notifyListeners();
    } else if (intent is UpdateFromServerIntent) {
      isLoading = true;
      notifyListeners();
      MyStringEntity newValue = await getRemoteUseCase.execute();
      myString = newValue.value;
      await storeLocalUseCase.execute(myString);
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadInitialValue() async {
    MyStringEntity storedEntity = await getLocalUseCase.execute();
    myString = storedEntity.value;
    isLoadingData = false; // ✅ Ensure this is updated correctly
    notifyListeners(); // ✅ This will trigger a UI update
  }
}
