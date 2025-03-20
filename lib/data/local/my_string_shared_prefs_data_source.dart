import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';

import 'my_string_local_data_source.dart';

/// Repository to handle local data persistence using SharedPreferences.
/// Implements a singleton pattern to avoid repeated `getInstance()` calls.
class MyStringSharedPrefsDataSource implements MyStringLocalDataSource {
  static SharedPreferences? _prefs;

  /// Initializes SharedPreferences once to prevent redundant calls.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Retrieves stored string value or assigns a default value if absent.
  @override
  Future<MyStringEntity> getMyString() async {
    if (_prefs == null) await init();

    String? storedValue = _prefs?.getString('my_string');

    if (storedValue == null) {
      storedValue = 'Default Value from DataStore'; // Ensure a valid default value.
      await _prefs?.setString('my_string', storedValue); // Store default value once.
    }

    return MyStringEntity(storedValue);
  }

  /// Stores a string value into SharedPreferences.
  @override
  Future<void> storeMyString(MyStringEntity value) async {
    if (_prefs == null) await init();

    await _prefs?.setString('my_string', value.value);
  }
}
