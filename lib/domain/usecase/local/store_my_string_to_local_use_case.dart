import '../../../data/local/my_string_local_repository.dart';
import '../../entity/my_string_entity.dart';

/// Use Case: Store a string into SharedPreferences.
class StoreMyStringToLocalUseCase {
  final MyStringLocalRepository sharedPrefsRepository;
  final MyStringLocalRepository hiveRepository;
  final LocalStore storeType;

  StoreMyStringToLocalUseCase({
    required this.sharedPrefsRepository,
    required this.hiveRepository,
    required this.storeType,
  });

  Future<void> execute(MyStringEntity value) async {
    switch (storeType) {
      case LocalStore.sharedPrefs:
          sharedPrefsRepository.storeMyString(value);
      case LocalStore.hive:
          hiveRepository.storeMyString(value);
    }
  }
}
