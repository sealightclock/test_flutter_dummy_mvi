import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';

import '../../../data/local/my_string_local_repository.dart';

/// Use Case: Retrieve the stored string from SharedPreferences.
class GetMyStringFromLocalUseCase {
  final MyStringLocalRepository sharedPrefsRepository;
  final MyStringLocalRepository hiveRepository;
  final LocalStore storeType;

  GetMyStringFromLocalUseCase({
    required this.sharedPrefsRepository,
    required this.hiveRepository,
    required this.storeType,
  });

  Future<MyStringEntity> execute() {
    switch (storeType) {
      case LocalStore.sharedPrefs:
        return sharedPrefsRepository.getMyString();
      case LocalStore.hive:
        return hiveRepository.getMyString();
      }
  }
}
