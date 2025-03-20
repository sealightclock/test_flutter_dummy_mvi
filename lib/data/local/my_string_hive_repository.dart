import 'package:hive_flutter/adapters.dart';
import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';
import 'package:test_flutter_dummy_mvi/util/my_string_constants.dart';
import 'my_string_local_repository.dart';

/// Repository to handle local data persistence using Hive.
class MyStringHiveRepository implements MyStringLocalRepository {
  static const String _key = 'my_string_key';
  static bool _isInitialized = false;
  static Box<String>? _box;

  /// Ensures Hive is initialized and the box is opened before usage.
  Future<void> _initialize() async {
    if (!_isInitialized) {
      await Hive.initFlutter();
      _box = await Hive.openBox<String>(hiveBoxName);
      _isInitialized = true;
    }
  }

  /// Retrieves stored string value or assigns a default value if absent.
  @override
  Future<MyStringEntity> getMyString() async {
    await _initialize(); // Ensure Hive is ready
    var value = _box?.get(_key, defaultValue: "Default Value from Hive") ?? "Default Value from Hive";
    return MyStringEntity(value);
  }

  /// Stores a string value into Hive Box.
  @override
  Future<void> storeMyString(MyStringEntity value) async {
    await _initialize(); // Ensure Hive is ready
    await _box?.put(_key, value.value);
  }
}
