import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';

class MyStringSharedPrefsRepository {
  Future<MyStringEntity> getMyString() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedValue = prefs.getString('my_string');

    if (storedValue == null) {
      storedValue = 'Default Value from DataStore'; // ✅ Ensure default value is returned
      await prefs.setString('my_string', storedValue); // ✅ Store the default value once
    }

    return MyStringEntity(storedValue);
  }

  Future<void> storeMyString(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('my_string', value);
  }
}
