import 'dart:async';

import '../../entity/my_string_entity.dart';

class MyStringBackendServerRepository {
  Future<MyStringEntity> fetchFromServer() async {
    await Future.delayed(Duration(seconds: 2));  // Simulate a delay
    return MyStringEntity("Server String: ${DateTime.now()}");
  }
}
