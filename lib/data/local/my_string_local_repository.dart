import '../../domain/entity/my_string_entity.dart';

abstract class MyStringLocalRepository {
  Future<MyStringEntity> getMyString();
  Future<void> storeMyString(MyStringEntity value);
}
