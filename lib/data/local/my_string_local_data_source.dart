import '../../domain/entity/my_string_entity.dart';

abstract class MyStringLocalDataSource {
  Future<MyStringEntity> getMyString();
  Future<void> storeMyString(MyStringEntity value);
}
