import 'dart:async';

import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';

import '../../util/my_string_exception.dart';
import 'my_string_backend_server_dio_api.dart';

/// Repository for fetching data from the backend server.
/// Supports switching between real server and mock data.
class MyStringBackendServerRepository {
  static const bool useMock = false; // Toggle to simulate mock data.

  /// Fetches data from the server or returns mock data.
  /// If fetching fails, throws `MyStringException`.
  Future<MyStringEntity> fetchFromServer() async {
    if (useMock) {
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay.
      return MyStringEntity("Mocked Server String: ${DateTime.now()}");
    }

    try {
      String content = await MyStringBackendServerDioApi().fetchContent();
      return MyStringEntity("Real Server String: $content");
    } catch (e) {
      throw MyStringException('Server fetch failed: $e');
    }
  }
}
