import '../../domain/entity/my_string_entity.dart';

abstract class MyStringRepository {
  Future<MyStringEntity> getMyStringFromLocal();
  Future<void> storeMyStringToLocal(MyStringEntity value);

  Future<MyStringEntity> getMyStringFromRemote();
}

