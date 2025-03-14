import '../../data/local/my_string_shared_prefs_repository.dart';

class StoreMyStringToSharedPrefsUseCase {
  final MyStringSharedPrefsRepository repository;

  StoreMyStringToSharedPrefsUseCase(this.repository);

  Future<void> execute(String value) async {
    return repository.storeMyString(value);
  }
}
