import 'package:hive/hive.dart';
import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';

import 'my_string_local_repository.dart';

/// Repository to handle local data persistence using Hive.
class MyStringHiveRepository implements MyStringLocalRepository {
  static const String _boxName = 'myBox';

  static const String _key = 'my_string_key';

  /// Retrieves stored string value or assigns a default value if absent.
  @override
  Future<MyStringEntity> getMyString() async {
    final box = await Hive.openBox<String>(_boxName);
    var value = box.get(_key, defaultValue: "Default Value from Hive");
    return MyStringEntity(value!);
  }

  /// Stores a string value into Hive Box:
  @override
  Future<void> storeMyString(MyStringEntity value) async {
    final box = await Hive.openBox<String>(_boxName);
    await box.put(_key, value.value);
  }
}
