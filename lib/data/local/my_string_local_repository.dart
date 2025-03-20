import '../../domain/entity/my_string_entity.dart';

abstract class MyStringLocalRepository {
  Future<MyStringEntity> getMyString();
  Future<void> storeMyString(MyStringEntity value);
}

enum LocalStore {
  sharedPrefs,
  hive,
}

// TODO: Change this if needed:
final storeType = LocalStore.hive;
