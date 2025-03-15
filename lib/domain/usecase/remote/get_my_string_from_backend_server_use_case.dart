import '../../../data/remote/my_string_backend_server_repository.dart';
import '../../entity/my_string_entity.dart';

class GetMyStringFromBackendServerUseCase {
  final MyStringBackendServerRepository repository;

  GetMyStringFromBackendServerUseCase({required this.repository});

  Future<MyStringEntity> execute() async {
    return repository.fetchFromServer();
  }
}
