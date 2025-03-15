import 'package:shared_preferences/shared_preferences.dart';

import '../../entity/my_string_entity.dart';

class MyStringSharedPrefsRepository {
  Future<MyStringEntity> getMyString() async {
    final prefs = await SharedPreferences.getInstance();
    return MyStringEntity(prefs.getString('my_string') ?? 'Default Value from DataStore');  // default value for debugging purposes
  }

  Future<void> storeMyString(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('my_string', value);
  }
}
