import 'dart:async';

import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';

import 'my_string_backend_server_dio_api.dart';

class MyStringBackendServerRepository {
  static const bool useMock = false;

  Future<MyStringEntity> fetchFromServer() async {
    if (useMock) {
      await Future.delayed(Duration(seconds: 2)); // Simulate a delay
      return MyStringEntity("Mocked Server String: ${DateTime.now()}");
    }

    String content = '';
    try {
      content = await MyStringBackendServerDioApi().fetchContent();
    } catch (e) {
      content = 'Error: $e';
    }

    return MyStringEntity("Real Server String: $content");
  }
}
