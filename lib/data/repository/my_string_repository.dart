import '../../domain/entity/my_string_entity.dart';

abstract class MyStringRepository {
  Future<MyStringEntity> getMyStringFromLocal();
  Future<void> storeMyStringToLocal(MyStringEntity value);

  Future<MyStringEntity> getMyStringFromRemote();
}

enum LocalStore {
  sharedPrefs,
  hive,
}

// TODO: Change this if needed:
final storeType = LocalStore.hive;
