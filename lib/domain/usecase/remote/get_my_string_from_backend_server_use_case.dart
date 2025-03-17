import 'package:test_flutter_dummy_mvi/data/remote/my_string_backend_server_repository.dart';
import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';

class GetMyStringFromBackendServerUseCase {
  final MyStringBackendServerRepository repository;

  GetMyStringFromBackendServerUseCase({required this.repository});

  // execute() is commonly used in Use Cases to execute the use case.
  Future<MyStringEntity> execute() async {
    // Do not use "await" if we are not modifying the value:
    return repository.fetchFromServer();
  }
}
