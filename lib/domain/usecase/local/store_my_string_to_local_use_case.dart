import 'package:test_flutter_dummy_mvi/data/local/my_string_shared_prefs_repository.dart';

import '../../entity/my_string_entity.dart';

/// Use Case: Store a string into SharedPreferences.
class StoreMyStringToLocalUseCase {
  final MyStringSharedPrefsRepository repository;

  StoreMyStringToLocalUseCase({required this.repository});

  Future<void> execute(MyStringEntity value) async => repository.storeMyString
    (value);
}
