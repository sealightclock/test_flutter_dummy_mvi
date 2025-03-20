import 'dart:async';

import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';

import '../../util/my_string_exception.dart';
import 'my_string_dio_api.dart';
import 'my_string_remote_data_source.dart';

/// Data Source for fetching data from the backend server using dio.
/// Supports switching between real server and mock data.
class MyStringDioDataSource implements MyStringRemoteDataSource {
  static const bool useMock = false; // Toggle to simulate mock data.

  /// Fetches data from the server or returns mock data.
  /// If fetching fails, throws `MyStringException`.
  @override
  Future<MyStringEntity> getMyString() async {
    if (useMock) {
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay.
      return MyStringEntity('MyStringDioDataSource: Mocked Server String: ${DateTime
          .now()}');
    }

    try {
      String content = await MyStringDioApi().fetchContent();
      return MyStringEntity('MyStringDioDataSource: Real Server String: $content');
    } catch (e) {
      throw MyStringException('MyStringDioDataSource: Server fetch failed: $e');
    }
  }

  @override
  Future<void> storeMyString(MyStringEntity value) {
    // TODO: implement storeMyString
    throw UnimplementedError();
  }
}
