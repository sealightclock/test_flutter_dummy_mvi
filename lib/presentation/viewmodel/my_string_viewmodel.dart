import 'package:flutter/material.dart';
import '../../domain/usecase/local/get_my_string_from_shared_prefs_use_case.dart';
import '../../domain/usecase/local/store_my_string_to_shared_prefs_use_case.dart';
import '../../domain/usecase/remote/get_my_string_from_backend_server_use_case.dart';

class MyStringViewModel extends ChangeNotifier {
  final GetMyStringFromSharedPrefsUseCase getMyStringFromSharedPrefsUseCase;
  final StoreMyStringToSharedPrefsUseCase storeMyStringToSharedPrefsUseCase;
  final GetMyStringFromBackendServerUseCase getMyStringFromBackendServerUseCase;

  MyStringViewModel(
      this.getMyStringFromSharedPrefsUseCase,
      this.storeMyStringToSharedPrefsUseCase,
      this.getMyStringFromBackendServerUseCase,
      ) {
    loadMyString();
  }

  String _myString = '';
  TextEditingController textController = TextEditingController();

  String get myString => _myString;

  Future<void> loadMyString() async {
    _myString = await getMyStringFromSharedPrefsUseCase.execute();
    textController.text = _myString;
    notifyListeners();
  }

  Future<void> updateFromUser() async {
    _myString = textController.text;
    await storeMyStringToSharedPrefsUseCase.execute(_myString);
    notifyListeners();
  }

  Future<void> updateFromServer() async {
    _myString = await getMyStringFromBackendServerUseCase.execute();
    textController.text = _myString;
    await storeMyStringToSharedPrefsUseCase.execute(_myString);
    notifyListeners();
  }
}
