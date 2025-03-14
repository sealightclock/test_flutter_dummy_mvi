import 'package:shared_preferences/shared_preferences.dart';

class MyStringSharedPrefsRepository {
  static const String key = 'my_string';

  Future<String> getMyString() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  Future<void> storeMyString(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
