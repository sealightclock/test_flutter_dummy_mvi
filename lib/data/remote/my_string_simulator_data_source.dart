import '../../domain/entity/my_string_entity.dart';
import '../../util/my_string_exception.dart';
import 'my_string_http_api.dart';
import 'my_string_remote_data_source.dart';

/// Data Source for fetching data from the backend server using http.
/// Supports switching between real server and mock data.
class MyStringSimulatorDataSource implements MyStringRemoteDataSource {
  /// Fetches data from the server or returns mock data.
  /// If fetching fails, throws `MyStringException`.
  @override
  Future<MyStringEntity> getMyString() async {
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay.
      return MyStringEntity('MyStringSimulatorDataSource: Mocked Server '
          'String: ${DateTime.now()}');
  }

  @override
  Future<void> storeMyString(MyStringEntity value) {
    // TODO: Implement storeMyString
    throw UnimplementedError();
  }
}
