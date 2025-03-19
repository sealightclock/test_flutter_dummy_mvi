import 'package:test_flutter_dummy_mvi/data/remote/my_string_remote_dio_repository.dart';
import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';

/// Use Case: Retrieve the latest string from the backend server.
class GetMyStringFromBackendServerUseCase {
  final MyStringBackendServerRepository repository;

  GetMyStringFromBackendServerUseCase({required this.repository});

  // execute() is commonly used in Use Cases to execute the use case.
  // Do not use "await" if we are not modifying the value:
  Future<MyStringEntity> execute() async => repository.fetchFromServer();
}
