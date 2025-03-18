import 'package:test_flutter_dummy_mvi/data/local/my_string_shared_prefs_repository.dart';

/// Use Case: Store a string into SharedPreferences.
class StoreMyStringToSharedPrefsUseCase {
  final MyStringSharedPrefsRepository repository;

  StoreMyStringToSharedPrefsUseCase({required this.repository});

  Future<void> execute(String value) async => repository.storeMyString(value);
}
