
import 'package:flutter/cupertino.dart';

import '../../domain/entity/my_string_entity.dart';
import '../../domain/usecase/local/get_my_string_from_shared_prefs_use_case.dart';
import '../../domain/usecase/local/store_my_string_to_shared_prefs_use_case.dart';
import '../../domain/usecase/remote/get_my_string_from_backend_server_use_case.dart';
import '../intent/my_string_intent.dart';

class MyStringViewModel with ChangeNotifier {
  final GetMyStringFromSharedPrefsUseCase getLocalUseCase;
  final StoreMyStringToSharedPrefsUseCase storeLocalUseCase;
  final GetMyStringFromBackendServerUseCase getRemoteUseCase;

  String myString = 'Default Value from ViewModel';
  bool isLoading = false;

  MyStringViewModel({
    required this.getLocalUseCase,
    required this.storeLocalUseCase,
    required this.getRemoteUseCase,
  });

  Future<void> handleIntent(MyStringIntent intent) async {
    if (intent is UpdateFromUserIntent) {
      myString = intent.newValue;
      await storeLocalUseCase.execute(myString);
    } else if (intent is UpdateFromServerIntent) {
      isLoading = true;
      notifyListeners();
      MyStringEntity newValue = (await getRemoteUseCase.execute());
      myString = newValue.value;
      await storeLocalUseCase.execute(myString);
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> loadInitialValue() async {
    myString = (await getLocalUseCase.execute()).value;
    notifyListeners();
  }
}
